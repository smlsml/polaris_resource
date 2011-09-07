# The Association class serves as the basis for associating resources.
# Resources have an association DSL that follows that of ActiveRecord:
#
# has_many :automobiles
#
# has_one :car
#
# belongs_to :car_club
# 
# This class acts as a proxy that will allow for lazy evaluation of an
# association. The proxy waits to make the request for the object until
# a method on the association is called. When this happens, because the
# method does not exist on the proxy object, method_missing will be
# called, the target object will be loaded, and then the method will be
# called on the loaded target.
module PolarisResource
  module Associations
    class Association < ActiveSupport::BasicObject

      # Associations can be loaded with several options.
      def initialize(owner, association, settings = {})
        # @owner stores the class that the association exists on.
        @owner = owner

        # @association stores the associated class, as named in the association
        # method (i.e. :automobile, :car, :car_club)
        @association = association

        # @target stores the loaded object. It is not typically accessed directly,
        # but instead should be accessed through the loaded_target method.
        @target = settings[:target]

        @filters = settings[:filters] || []
        
        @includes = []

        # @options holds the chosen options for the association. Several of these
        # options are set in the subclass' initializer.
        @options = settings[:options] || {}

        # In some cases, the association name will not match that of the class
        # that should be instantiated when it is invoked. Here, we can specify
        # that this association uses a specified class as its target. When the
        # request is made for the association, this class will be used to
        # instantiate this object or collection.
        @options[:class_name] = settings[:options] || @association.to_s.classify
        
        # @association_class stores the class of the association, constantized
        # from the named association (i.e. Automobile, Car, CarClub)
        @association_class = @options[:class_name].constantize
      end

      # The proxy implements a few methods that need to be delegated to the target
      # so that they will work as expected.
      def id
        loaded_target.id
      end

      def nil?
        loaded_target.nil?
      end

      def to_param
        loaded_target.to_param
      end

      def try(method, *args, &block)
        loaded_target.try(method, *args, &block)
      end

      def includes(*associations)
        associations.each do |association|
          @includes << association unless @includes.include?(association)
        end
        self
      end

      # The stub method can be used to mock out an association without
      # having to really load the target.
      def stub(mock)
        @mock = mock
      end

      # This is left to be implemented by the subclasses as it will operate
      # differently in each case.
      def load_target!
      end

      private

      # The loaded_target method holds a cached version of the loaded target.
      # This method is used to access the proxied object. Since a request will
      # be made when a method is invoked on the object, and this can happen
      # very often, we are caching the target here, so that only a single
      # request will be made.
      def loaded_target
        return @mock if @mock
        @target ||= load_target!
        if Array === @target && !@filters.empty?
          @filters.uniq.inject(@target.dup) do |target, filter|
            filter.call(target)
          end
        else
          @target
        end
      end

      # The method_missing hook will be called when methods that do not exist
      # on the proxy object are invoked. This is the point at which the proxied
      # object is loaded, if it has not been loaded already.
      def method_missing(m, *args, &block)
        if filter = @association_class.find_filter(m)
          with_filter(filter)
        else
          loaded_target.send(m, *args, &block)
        end
      end

    end
  end
end