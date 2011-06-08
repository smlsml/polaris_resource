module PolarisClient
  module Associations
    
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def belongs_to_resource(association)
        define_method association do
          instance_variable_get("@#{association}") ||
            instance_variable_set("@#{association}", PolarisResource::Associations::BelongsToAssociation.new(self, association))
        end
        
        define_method "#{association}=" do |target|
          instance_variable_set("@#{association}", PolarisResource::Associations::BelongsToAssociation.new(self, association, target))
          send("#{association}_id=", target.id)
        end
        
        define_method "#{association}_id" do
          instance_variable_get("@#{association}_id")
        end
        
        define_method "#{association}_id=" do |value|
          instance_variable_set("@#{association}_id", value)
        end
      end

      def has_many_resources(association)
        define_method association do
          PolarisResource::Associations::HasManyAssociation.new(self, association)
        end
        
        define_method "#{association}=" do |target|
          PolarisResource::Associations::HasManyAssociation.new(self, association, target)
        end
      end

      def has_one_resource(association)
        define_method association do
          PolarisResource::Associations::HasOneAssociation.new(self, association)
        end
        
        define_method "#{association}=" do |target|
          PolarisResource::Associations::HasOneAssociation.new(self, association, target)
        end
      end

    end

  end
end