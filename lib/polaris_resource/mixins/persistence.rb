module PolarisResource
  module Persistence
    extend ActiveSupport::Concern

    module InstanceMethods

      def save
        if new_record?
          built_object = self.class.post(*UrlBuilder.save(self.class, nil, attributes_without_basic_attributes))
        else
          built_object = self.class.put(*UrlBuilder.save(self.class, id, attributes_without_basic_attributes))
        end
        merge_attributes(built_object.attributes)
      end

      def update_attributes(new_attributes)
        merge_attributes(new_attributes)
        save
      end

    end

    module ClassMethods

      def create(new_attributes = {})
        new(new_attributes).tap { |new_instance| new_instance.save }
      end
      alias :create! :create

    end

  end
end