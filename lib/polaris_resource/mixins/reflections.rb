module PolarisResource
  module Reflections
    extend ActiveSupport::Concern

    module ClassMethods

      def create_reflection(macro, name, options)
        Reflection.new(macro, name, options).tap do |reflection|
          reflections.merge!(name => reflection)
        end
      end

      def reflections
        @reflections ||= {}
      end

      def reflect_on_association(association)
        reflections[association.to_sym].is_a?(Reflection) ? reflections[association.to_sym] : nil
      end

    end

  end
end