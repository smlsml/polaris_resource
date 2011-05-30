module PolarisResource
  class Base
    module Finders

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        
        def all
          find_all
        end

        def find(*id_or_ids)
          if id_or_ids.length == 1
            case id_or_ids.first
            when Integer
              find_one(id_or_ids.first)
            when Array
              find_some(id_or_ids.first)
            else
              raise ArgumentError, "Unrecognized argument."
            end
          else
            find_some(id_or_ids)
          end
        end

        def find_one(id)
          response = PolarisResource::Request.get(find_one_uri(id))
          handle_response(response, id)
        end

        def find_one_uri(id)
          "/#{model_name.underscore.pluralize}/#{id}"
        end

        def find_some(ids)
          response = PolarisResource::Request.get(find_some_uri(ids))
          handle_response(response, ids)
        end

        def find_some_uri(ids)
          "/#{model_name.underscore.pluralize}?ids=#{ids.join(',')}"
        end
        
        def find_all
          response = PolarisResource::Request.get(find_all_uri)
          handle_response(response)
        end
        
        def find_all_uri
          "/#{model_name.underscore.pluralize}"
        end

        def handle_response(response, id_or_ids = nil)
          case response.code
          when 200, 201
            build_from_response(response)
          when 404
            case id_or_ids
            when Array
              raise RecordNotFound, "Couldn't find all Dogs with IDs (#{id_or_ids.join(', ')})"
            when Integer
              raise RecordNotFound, "Couldn't find #{model_name} with ID=#{id_or_ids}"
            else
              raise RecordNotFound
            end
          end
        end

      end

    end
  end
end