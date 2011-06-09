module PolarisResource
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
            raise ArgumentError, "Unrecognized argument (#{args.first.inspect})."
          end
        else
          find_some(args)
        end
      end

      def find_one(id)
        _get(find_one_uri(id), {}, id)
      end

      def find_one_uri(id)
        "/#{model_name.underscore.pluralize}/#{id}"
      end

      def find_some(ids)
        _get(find_all_uri, { :ids => ids }, ids)
      end

      def find_all
        _get(find_all_uri)
      end

      def find_all_uri
        "/#{model_name.underscore.pluralize}"
      end

      def where(query_attributes)
        Relation.new(self).where(query_attributes)
      end

      def limit(amount)
        Relation.new(self).limit(amount)
      end

      def page(page_number)
        Relation.new(self).page(page_number)
      end

      def handle_response(response, id_or_ids = nil)
        case response.code
        when 200..299
          build_from_response(response)
        when 404
          raise_not_found(id_or_ids)
        end
      end

      def raise_not_found(id_or_ids)
        case id_or_ids
        when Array
          raise ResourceNotFound, "Couldn't find all #{model_name.pluralize} with IDs (#{id_or_ids.join(', ')})"
        when Integer
          raise ResourceNotFound, "Couldn't find #{model_name} with ID=#{id_or_ids}"
        else
          raise ResourceNotFound
        end
      end

      def _get(path, params = {}, id_or_ids = nil)
        response = PolarisResource::Request.get(path, params)
        ActiveSupport::Notifications.instrument('request.polaris_resource', :path => path, :params => params, :method => :get, :class => self, :response => response) do
          handle_response(response, id_or_ids)
        end
      end
      private :_get

    end

  end
end