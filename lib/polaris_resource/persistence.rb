module PolarisResource
  module Persistence

    def save
      if new_record?
        response = PolarisResource::Request.post(save_uri, attributes_without_id)
      else
        response = PolarisResource::Request.put(save_uri, attributes_without_id)
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
      merge_attributes(new_attributes)
      save
    end

  end
end