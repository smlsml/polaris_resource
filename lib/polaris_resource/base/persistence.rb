module Polaris
  module Resource
    class Base
      module Persistence
        
        def save
          if new_record?
            response = Polaris::Resource::Request.post(save_uri, attributes_without_id)
          else
            response = Polaris::Resource::Request.put(save_uri, attributes_without_id)
          end
          build_from_response(response)
        end
        
        def save_uri
          uri = "/#{self.class.model_name.underscore.pluralize}"
          uri << "/#{id}" unless new_record?
          uri
        end
        private :save_uri
        
        def update_attributes(new_attributes)
          new_attributes.each do |key, value|
            update_attribute(key, value)
          end
          save
        end
        
      end
    end
  end
end