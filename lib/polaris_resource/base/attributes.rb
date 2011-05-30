module PolarisResource
  class Base
    module Attributes

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def property(name)
          default_attributes.store(name.to_sym, nil)

          define_method name.to_sym do
            attributes[name.to_sym]
          end

          define_method "#{name}=".to_sym do |value|
            attributes[name.to_sym] = value
          end
        end

        def default_attributes
          @attributes ||= HashWithIndifferentAccess.new(superclass.respond_to?(:default_attributes) ? superclass.default_attributes : {})
        end

      end

      def attributes
        @attributes ||= self.class.default_attributes.dup
      end

      def attributes_without_id
        attributes.reject { |k,v| k == 'id' }
      end

      def merge_attributes(new_attributes)
        new_attributes.each do |key, value|
          update_attribute(key, value)
        end
      end

      def update_attribute(attribute, value)
        attributes[attribute] = value
      end

    end
  end
end