module PolarisResource
  module Reflections
    extend ActiveSupport::Concern

    module ClassMethods
      def create_reflection(macro, name)
        reflection = Reflection.new(macro, name)
        reflections.merge!(name => reflection)
        reflection
      end

      def reflections
        class_variable_defined?(:@@reflections) ? class_variable_get(:@@reflections) : (class_variable_set(:@@reflections, {}))
      end

      def reflect_on_association(association)
        reflections[association.to_sym].is_a?(Reflection) ? reflections[association.to_sym] : nil
      end

    end
    
  end
end
  