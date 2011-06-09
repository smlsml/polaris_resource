module PolarisResource
  class Request

    def self.cache
      @cache ||= {}
    end

    def self.get(path, params = {})
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

    def self.post(path, params = {})
      response = Typhoeus::Request.post(build_path(path), build_params(params))
      PolarisResource::Response.new(response)
    end

    def self.put(path, params = {})
      response = Typhoeus::Request.put(build_path(path), build_params(params))
      PolarisResource::Response.new(response)
    end

    def self.build_path(path)
      "#{PolarisResource::Configuration.host}#{path}"
    end

    def self.build_params(params)
      params.empty? ? {} : { :params => params }
    end

  end
end