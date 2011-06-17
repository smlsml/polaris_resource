module PolarisResource
  module Associations
    autoload :Association,          'polaris_resource/associations/association'
    autoload :BelongsToAssociation, 'polaris_resource/associations/belongs_to_association'
    autoload :HasManyAssociation,   'polaris_resource/associations/has_many_association'
    autoload :HasOneAssociation,    'polaris_resource/associations/has_one_association'

    extend ActiveSupport::Concern

    module ClassMethods

      def belongs_to(association, options = {})
        attribute_id_sym  = "#{association}_id".to_sym

        property attribute_id_sym
        
        create_reflection(:belongs_to, association)

        define_method association do
          instance_variable_get("@#{association}") ||
            instance_variable_set("@#{association}", BelongsToAssociation.new(self, association, nil, options))
        end

        define_method "#{association}=" do |target|
          instance_variable_set("@#{association}", BelongsToAssociation.new(self, association, target, options))
          send("#{association}_id=", target.id)
        end
      end

      def has_many(association, options = {})
        create_reflection(:has_many, association)

        define_method association do
          instance_variable_get("@#{association}") ||
            instance_variable_set("@#{association}", HasManyAssociation.new(self, association, nil, options))
        end
      end

      def has_one(association, options = {})
        create_reflection(:has_one, association)

        define_method association do
          instance_variable_get("@#{association}") ||
            instance_variable_set("@#{association}", HasOneAssociation.new(self, association, nil, options))
        end

        define_method "#{association}=" do |target|
          instance_variable_set("@#{association}", HasOneAssociation.new(self, association, target, options))
        end
      end

    end

  end
end