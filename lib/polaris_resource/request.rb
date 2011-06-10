module PolarisResource
  class Request
    
    class << self

      def get(path, params = {})
        @cached = false
        response = begin
          cached_response = cache[[path, params]]
          if cached_response
            @cached = true
          else
            cached_response = cache[[path, params]] = Typhoeus::Request.get(build_path(path), build_params(params))
          end
          cached_response
        end
        PolarisResource::Response.new(response, @cached)
      end

      def post(path, params = {})
        response = Typhoeus::Request.post(build_path(path), build_params(params))
        PolarisResource::Response.new(response)
      end

      def put(path, params = {})
        response = Typhoeus::Request.put(build_path(path), build_params(params))
        PolarisResource::Response.new(response)
      end
    
      def cache
        @cache ||= {}
      end
      private :cache

      def build_path(path)
        "#{PolarisResource::Configuration.host}#{path}"
      end
      private :build_path

      def build_params(params)
        params.empty? ? {} : { :params => params }
      end
      private :build_params
      
    end

  end
end