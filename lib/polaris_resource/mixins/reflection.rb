module PolarisResource
  module Reflection
    extend ActiveSupport::Concern

    module ClassMethods
      def create_reflection(macro, name)
        reflection = AssociationReflection.new(macro, name)
        reflections.merge!(name => reflection)
        reflection
      end

      def reflections
        class_variable_defined?(:@@reflections) ? class_variable_get(:@@reflections) : (class_variable_set(:@@reflections, {}))
      end

      def reflect_on_association(association)
        reflections[association.to_sym].is_a?(AssociationReflection) ? reflections[association.to_sym] : nil
      end

    end
    
    class AssociationReflection
      attr_reader :macro, :name

      def initialize(macro, name)
        @macro, @name = macro, name
      end

      def klass
        @klass ||= class_name.constantize
      end

      def class_name
        name.to_s.singularize.camelize
      end

      def build_association(*options)
        klass.new(*options)
      end
    end
  end
end
  