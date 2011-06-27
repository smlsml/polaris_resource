module PolarisResource
  class Request
    attr_reader :path, :params, :method

    def initialize(path, options = {})
      @path      = path
      @params    = options[:params] || {}
      @method    = options[:method]
      
      if @method == :put
        @method = options[:method] = :post
        options[:params] = @params.merge(:_method => :put)
      end

      @request = Typhoeus::Request.new(Configuration.host + path, options)
    end

    def cache_key
      [path, params].hash
    end

    def response
      @response ||= begin
        if cached_response = RequestCache.cache[cache_key]
          Response.new(cached_response, true)
        else
          RequestCache.cache[cache_key] = @request.response
          Response.new(RequestCache.cache[cache_key])
        end
      end
    end

    def method_missing(m, *args, &block)
      if @request.respond_to?(m)
        @request.send(m, *args, &block)
      else
        super
      end
    end

    def self.quick(method, path, params)
      options = { :method => method }
      options.merge!(:params => params) if params
      request = new(path, options)
      request_queue = RequestQueue.new
      request_queue << request
      request_queue.run!
      request
    end

  end
end