module PolarisResource
  class Request < Typhoeus::Request
    attr_reader :path, :params, :method

    def initialize(path, options = {})
      if options[:method] == :put
        options[:method] = :post
        options[:params].merge!(:_method => :put)
      end
      
      options[:username] = Configuration.username if Configuration.username
      options[:password] = Configuration.password if Configuration.password

      super(Configuration.host + path, options)
    end

    def cache_key
      [method, url, params].hash
    end

    def response=(response)
      RequestCache.cache[cache_key] = response
      response.tag_for_caching!
      super
    end

    def response
      RequestQueue.run! if RequestQueue.has_request?(self)
      RequestCache.cache[cache_key] || super
    end

    def self.enqueue(method, path, params)
      options = { :method => method }
      options.merge!(:params => params) if params
      new(path, options).tap do |request|
        RequestQueue.enqueue(request)
      end
    end

  end
end