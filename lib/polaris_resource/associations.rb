require 'polaris_resource/associations/association'
require 'polaris_resource/associations/belongs_to_association'
require 'polaris_resource/associations/has_many_association'
require 'polaris_resource/associations/has_one_association'

module PolarisResource
  module Associations

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def belongs_to(association)
        attribute_id_sym  = "#{association}_id".to_sym

        property attribute_id_sym

        define_method association do
          BelongsToAssociation.new(self, association)
        end
      end

      def has_many(association)
        define_method association do
          HasManyAssociation.new(self, association)
        end
      end

      def has_one(association)
        define_method association do
          HasOneAssociation.new(self, association)
        end
      end

    end

  end
end