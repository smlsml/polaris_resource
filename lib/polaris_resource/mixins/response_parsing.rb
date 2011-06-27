module PolarisResource
  module ResponseParsing
    extend ActiveSupport::Concern

    module ClassMethods

      def response_from_request(request, metadata)
        ResponseParser.parse(self, request, metadata)
      end

    end

    module InstanceMethods

      def build_from_response(response)
        content = Yajl::Parser.parse(response.body)['content']
        merge_attributes(content)
      end
      private :build_from_response

    end
  end
end