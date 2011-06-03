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

        def find(*args)
          options = args.extract_options!
          if args.length == 1
            case args.first
            when Integer, String
              find_one(args.first.to_i)
            when Array
              find_some(args.first)
            else
              raise ArgumentError, "Unrecognized argument (#{id_or_ids.first.inspect})."
            end
          else
            find_some(args)
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
          response = PolarisResource::Request.get(find_all_uri, :ids => ids)
          handle_response(response, ids)
        end
        
        def find_all
          response = PolarisResource::Request.get(find_all_uri)
          handle_response(response)
        end
        
        def find_all_uri
          "/#{model_name.underscore.pluralize}"
        end
        
        def where(query_attributes)
          query_attributes.each do |key, value|
            raise UnrecognizedProperty, ":#{key} is not a recognized #{model_name} property." unless attribute_defined?(key)
          end
          response = PolarisResource::Request.get(find_all_uri, query_attributes)
          handle_response(response)
        end
        
        def limit(amount)
          response = PolarisResource::Request.get(find_all_uri, :limit => amount)
          handle_response(response)
        end
        
        def page(page_number)
          response = PolarisResource::Request.get(find_all_uri, page_params(page_number))
          handle_response(response)
        end
        
        def page_params(page_number)
          offset = (page_number - 1) * results_per_page
          { :limit => results_per_page, :offset => offset }
        end

        def handle_response(response, id_or_ids = nil)
          case response.code
          when 200, 201
            build_from_response(response)
          when 404
            case id_or_ids
            when Array
              raise ResourceNotFound, "Couldn't find all #{model_name.pluralize} with IDs (#{id_or_ids.join(', ')})"
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