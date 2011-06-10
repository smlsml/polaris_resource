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

        define_method association do
          BelongsToAssociation.new(self, association, nil, options)
        end
      end

      def has_many(association, options = {})
        define_method association do
          HasManyAssociation.new(self, association, nil, options)
        end
      end

      def has_one(association, options = {})
        define_method association do
          HasOneAssociation.new(self, association, nil, options)
        end
      end

    end

  end
end