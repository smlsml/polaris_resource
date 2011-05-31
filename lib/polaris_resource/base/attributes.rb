module PolarisResource
  class Base
    module Attributes

      def self.included(base)
        base.send(:extend, ClassMethods)
        base.send(:include, ActiveModel::Validations)
        base.send(:include, ActiveModel::Dirty)
      end

      module ClassMethods

        def property(name)
          default_attributes.store(name.to_sym, nil)

          define_method name.to_sym do
            attributes[name.to_sym]
          end

          unless name.to_sym == :id
            define_method "#{name}=".to_sym do |value|
              send("#{name}_will_change!")
              attributes[name.to_sym] = value
            end
          end
          
          define_attribute_methods [name]
        end

        def default_attributes
          @attributes ||= HashWithIndifferentAccess.new(superclass.respond_to?(:default_attributes) ? superclass.default_attributes : {})
        end

      end

      def attributes
        @attributes ||= self.class.default_attributes.dup
      end
      
      def read_attribute_for_validation(key)
        @attributes[key]
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