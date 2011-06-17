module PolarisResource
  module Associations
    class Association < ActiveSupport::BasicObject
      
      def initialize(owner, association, target = nil, options = {})
        @owner       = owner
        @association = association
        @target      = target
        @options     = {}
        
        @options[:polymorphic] = options[:polymorphic] || false
        @options[:class_name]  = options[:class_name]  || @association.to_s.classify
        @options[:foreign_key] = options[:foreign_key] || "#{@association}_id".to_sym
      end
      
      def id
        loaded_target.id
      end
      
      def nil?
        loaded_target.nil?
      end
      
      def to_param
        loaded_target.to_param
      end
      
      def load_target!
        # Left to be implemented by the subclasses
      end
      
      def loaded_target
        return @mock if @mock
        @target ||= load_target!
      end
      
      def stub(mock)
        @mock = mock
      end
      
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