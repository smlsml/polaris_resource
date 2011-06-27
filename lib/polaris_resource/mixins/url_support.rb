module PolarisResource
  module UrlSupport
    extend ActiveSupport::Concern

    module ClassMethods

      def url_name
        @url_name ||= model_name.underscore
      end
      alias_method :singular_url_name, :url_name

      def plural_url_name
        url_name.pluralize
      end

      def set_base_url(url_name)
        @url_name = url_name
      end

    end

  end
end