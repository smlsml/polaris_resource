module PolarisResource
  module Finders
    extend ActiveSupport::Concern

    module ClassMethods

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
      
      def all
        find_all
      end
      
      def first
        limit(1).first
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
      
      def results_per_page
        @results_per_page || 10
      end

      def results_per_page=(_results_per_page)
        @results_per_page = _results_per_page
      end

      def _get(path, params = {}, id_or_ids = nil)
        response = PolarisResource::Request.get(path, params)
        ActiveSupport::Notifications.instrument('request.polaris_resource', :path => path, :params => params, :method => :get, :class => self, :response => response) do
          handle_response(response, id_or_ids)
        end
      end
      private :_get
      
      def find_one(id)
        _get(find_one_uri(id), {}, id)
      end
      private :find_one

      def find_one_uri(id)
        "/#{model_name.underscore.pluralize}/#{id}"
      end
      private :find_one_uri

      def find_some(ids)
        _get(find_all_uri, { :ids => ids }, ids)
      end
      private :find_some

      def find_all
        _get(find_all_uri)
      end
      private :find_all

      def find_all_uri
        "/#{model_name.underscore.pluralize}"
      end

    end

  end
end