module PolarisResource
  module RequestHandling
    extend ActiveSupport::Concern

    module ClassMethods

      def request_queue
        @request_queue ||= RequestQueue.new
      end

      def get(path, params = {}, metadata = {})
        request = build_request(:get, path, params)
        quick_request(request)
        response_from_request(request, metadata)
      end

      def post(path, params = {}, metadata = {})
        request = build_request(:post, path, params)
        quick_request(request)
        response_from_request(request, metadata)
      end

      def put(path, params = {}, metadata = {})
        request = build_request(:put, path, params)
        quick_request(request)
        response_from_request(request, metadata)
      end

      def quick_request(request)
        request_queue << request
        request_queue.run!
      end

      def build_request(method, path, params)
        Request.new(path, :method => method, :params => params)
      end
      
      def response_from_request(request, metadata)
        ActiveSupport::Notifications.instrument('request.polaris_resource', :path => request.path, :params => request.params, :method => request.method, :class => self, :response => request.response) do
          handle_response(request, metadata)
        end
      end

    end

  end
end