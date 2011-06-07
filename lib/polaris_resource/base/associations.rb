module PolarisResource
  class Base
    module Associations

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def belongs_to(association)
          attribute_id_sym  = "#{association}_id".to_sym

          property attribute_id_sym

          define_method association do
            PolarisResource::Associations::BelongsToAssociation.new(self, association)
          end
        end

        def has_many(association)
          define_method association do
            PolarisResource::Associations::HasManyAssociation.new(self, association)
          end
        end

        def has_one(association)
          define_method association do
            PolarisResource::Associations::HasOneAssociation.new(self, association)
          end
        end

      end

    end
  end
end