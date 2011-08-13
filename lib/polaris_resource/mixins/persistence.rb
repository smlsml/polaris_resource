module PolarisResource
  module Persistence
    extend ActiveSupport::Concern

    module InstanceMethods

      def save
        attributes_for_save = { self.class.to_s.underscore => attributes_without_basic_attributes.reject { |k,v| v.nil? } }
        
        if new_record?
          built_object = self.class.post(*UrlBuilder.save(self.class, nil, attributes_for_save))
        else
          built_object = self.class.put(*UrlBuilder.save(self.class, id, attributes_for_save))
        end
        merge_attributes(built_object.attributes)
      end

      def update_attributes(new_attributes)
        merge_attributes(new_attributes)
        save
      end
      
      def destroy
        self.class.delete(UrlBuilder.destroy(self.class, id))
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