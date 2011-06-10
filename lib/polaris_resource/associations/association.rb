module PolarisResource
  module Associations
    class Association < ActiveSupport::BasicObject
      
      def initialize(owner, association, target = nil, options = {})
        @owner       = owner
        @association = association
        @target      = target
        @options     = {}
        
        @options[:polymorphic] = options[:polymorphic] || false
      end
      
      def id
        loaded_target.id
      end
      
      def id=(id)
        loaded_target.id = id
      end
      
      def nil?
        loaded_target.nil?
      end
      
      def load_target!
        # Left to be implemented by the subclasses
      end
      
      def loaded_target
        @target ||= load_target!
      end
      
      def reset
        @target = nil
      end
      alias_method :reset!, :reset
      
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