module PolarisResource
  class Base
    module Finders

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

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

        def handle_response(response, id_or_ids)
          case response.code
          when 200
            build_from_response(response)
          when 404
            if Array === id_or_ids
              raise RecordNotFound, "Couldn't find all Dogs with IDs (#{id_or_ids.join(', ')})"
            else
              raise RecordNotFound, "Couldn't find #{model_name} with ID=#{id_or_ids}"
            end
          end
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