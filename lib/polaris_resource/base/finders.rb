module PolarisResource
  class Base
    module Finders

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        
        def results_per_page
          @results_per_page || 10
        end
        
        def results_per_page=(_results_per_page)
          @results_per_page = _results_per_page
        end
        
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
        
        def where(query_attributes)
          response = PolarisResource::Request.get(where_uri(query_attributes))
          handle_response(response)
        end
        
        def where_uri(query_attributes)
          query_parameter_pairs = []
          HashWithIndifferentAccess.new(query_attributes).sort.each do |key, value|
            if default_attributes.keys.include?(key)
              query_parameter_pairs << "#{key}=#{value}"
            else
              raise UnrecognizedProperty, ":#{key} is not a recognized #{model_name} property."
            end
          end
          find_all_uri << "?" << query_parameter_pairs.join("&")
        end
        
        def limit(amount)
          response = PolarisResource::Request.get(limit_uri(amount))
          handle_response(response)
        end
        
        def limit_uri(amount)
          find_all_uri << "?" << "limit=#{amount.to_i}"
        end
        
        def page(page_number)
          response = PolarisResource::Request.get(page_uri(page_number))
          handle_response(response)
        end
        
        def page_uri(page_number)
          offset = (page_number - 1) * results_per_page
          find_all_uri << "?limit=#{results_per_page}&offset=#{offset}"
        end

        def handle_response(response, id_or_ids = nil)
          case response.code
          when 200, 201
            build_from_response(response)
          when 404
            case id_or_ids
            when Array
              raise ResourceNotFound, "Couldn't find all Dogs with IDs (#{id_or_ids.join(', ')})"
            when Integer
              raise ResourceNotFound, "Couldn't find #{model_name} with ID=#{id_or_ids}"
            else
              raise ResourceNotFound
            end
          end
        end

      end

    end
  end
end