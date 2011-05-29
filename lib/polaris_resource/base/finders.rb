module Polaris
  module Resource
    class Base
      module Finders
        
        def self.included(base)
          base.extend(ClassMethods)
        end
        
        module ClassMethods
          
          def find(id)
            response = Polaris::Resource::Request.get(find_uri(id))
            build_from_response(response)
          end
          
          def find_uri(id)
            "/#{model_name.underscore.pluralize}/#{id}"
          end
          
        end

        # def self.find(id_or_ids)
        #   response = Typhoeus::Request.get(_find_uri(id_or_ids))
        #   build_from_response(response)
        # end

        # def self._find_uri(id_or_ids)
        #   "#{Polaris::Configuration.host}"
        # end

      end
    end
  end
end