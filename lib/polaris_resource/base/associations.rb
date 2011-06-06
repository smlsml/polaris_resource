module PolarisResource
  class Base
    module Associations

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def belongs_to(association)
          attribute_id_sym  = "#{association}_id".to_sym
          attribute_uri_sym = "belongs_to_#{association}_uri".to_sym

          property attribute_id_sym

          define_method association do
            if send(attribute_id_sym)
              association.to_s.classify.constantize.send(:get, send(attribute_uri_sym))
            end
          end

          define_method attribute_uri_sym do
            "/#{association.to_s.pluralize}/#{attributes[attribute_id_sym]}" if attributes[attribute_id_sym]
          end
          private attribute_uri_sym
        end

        def has_many(association)
          attribute_uri_sym = "has_many_#{association}_uri".to_sym

          define_method association do
            if new_record?
              []
            else
              association.to_s.classify.constantize.send(:get, send(attribute_uri_sym))
            end
          end

          define_method attribute_uri_sym do
            "/#{self.class.model_name.underscore.pluralize}/#{id}/#{association.to_s.pluralize}" if id
          end
          private attribute_uri_sym
        end

        def has_one(association)
          attribute_uri_sym = "has_one_#{association}_uri".to_sym

          define_method association do
            unless new_record?
              association.to_s.classify.constantize.send(:get, send(attribute_uri_sym))
            end
          end

          define_method attribute_uri_sym do
            "/#{self.class.model_name.underscore.pluralize}/#{id}/#{association}" if id
          end
          private attribute_uri_sym
        end

      end

    end
  end
end