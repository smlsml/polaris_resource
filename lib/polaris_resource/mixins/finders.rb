module PolarisResource
  module Finders
    extend ActiveSupport::Concern

    module ClassMethods

      def find(*args)
        options = args.extract_options!
        if args.length == 1
          case args.first
          when Integer, String
            get(UrlBuilder.find_one(self, args.first.to_i))
          when Array
            get(UrlBuilder.find_some(self, args.first))
          else
            raise ArgumentError, "Unrecognized argument (#{args.first.inspect})."
          end
        else
          get(UrlBuilder.find_some(self, args))
        end
      end

      def all
        get(UrlBuilder.find_all(self))
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

    end

  end
end