module PolarisResource
  module RequestHandling
    extend ActiveSupport::Concern

    module ClassMethods

      def get(path, params = nil, metadata = {})
        request = Request.quick(:get, path, params)
        response_from_request(request, metadata)
      end

      def post(path, params = nil, metadata = {})
        request = Request.quick(:post, path, params)
        response_from_request(request, metadata)
      end

      def put(path, params = nil, metadata = {})
        request = Request.quick(:put, path, params)
        response_from_request(request, metadata)
      end

      def delete(path, params = nil, metadata = {})
        request = Request.quick(:delete, path, params)
        response_from_request(request, metadata)
      end

    end

  end
end