module PolarisResource
  module Persistence
    extend ActiveSupport::Concern

    module InstanceMethods

      def save
        if new_record?
          response = self.class.post(save_uri, attributes_without_id)
        else
          response = self.class.put(save_uri, attributes_without_id)
        end
        build_from_response(response)
      end

      def save_uri
        uri = "/#{self.class.plural_url_name}"
        uri << "/#{id}" unless new_record?
        uri
      end
      private :save_uri

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