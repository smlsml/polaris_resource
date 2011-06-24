# The Association class serves as the basis for associating resources.
# Resources have an association DSL that follows that of ActiveRecord:
#
# has_many :automobiles
# has_one :car
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
      
      def initialize(owner, association, target = nil, options = {})
        # The class that the association exists on.
        @owner       = owner
        
        # The associated class, as named in the association method (i.e. :automobile, :car, :car_club)
        @association = association
        
        # The loaded object.
        @target      = target
        
        # Options for the association.
        @options     = {}
        
        # Marks an association as polymorphic.
        @options[:polymorphic] = options[:polymorphic] || false
        
        # Specifies that this association uses a specified class as its target.
        @options[:class_name]  = options[:class_name]  || @association.to_s.classify
        
        # Specifies the key used to make a request across a join.
        @options[:foreign_key] = options[:foreign_key] || "#{@association}_id".to_sym
      end
      
      # The proxy implements a few methods that need to be overridden so that they will work as expected.
      def id
        loaded_target.id
      end
      
      def nil?
        loaded_target.nil?
      end
      
      def to_param
        loaded_target.to_param
      end
      
      # The stub can be used to mock out an association without having to really load the target.
      def stub(mock)
        @mock = mock
      end
      
      private
      
      # This is left to be implemented by the subclasses as it will operate differently in each case.
      def load_target!
      end
      
      # Cached version of the loaded target.
      def loaded_target
        return @mock if @mock
        @target ||= load_target!
      end
      
      # Called when methods that do not exist on the proxy object are invoked.
      def method_missing(m, *args, &block)
        if loaded_target.respond_to?(m)
          loaded_target.send(m, *args, &block)
        else
          super
        end
      end
      
    end
  end
end