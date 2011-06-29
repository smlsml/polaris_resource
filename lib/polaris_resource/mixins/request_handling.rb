module PolarisResource
  module RequestHandling
    extend ActiveSupport::Concern

    module ClassMethods

      def get(path, params = nil, metadata = {}, &block)
        request = Request.enqueue(:get, path, params)
        request.on_complete = block if block_given?
        response_from_request(request, metadata)
      end

      def post(path, params = nil, metadata = {}, &block)
        request = Request.enqueue(:post, path, params)
        request.on_complete = block if block_given?
        response_from_request(request, metadata)
      end

      def put(path, params = nil, metadata = {}, &block)
        request = Request.enqueue(:put, path, params)
        request.on_complete = block if block_given?
        response_from_request(request, metadata)
      end

      def delete(path, params = nil, metadata = {}, &block)
        request = Request.enqueue(:delete, path, params)
        request.on_complete = block if block_given?
        response_from_request(request, metadata)
      end

    end

  end
end