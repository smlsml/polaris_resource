module PolarisResource
  class Request

    def self.cache
      @cache ||= {}
    end

    def self.get(path, params = {})
      response = nil
      ActiveSupport::Notifications.instrument("request.polaris_resource", :method => :get, :path => build_path(path), :params => params) do
        response = cache[[path, params]] ||= Typhoeus::Request.get(build_path(path), build_params(params))
      end
      
      ActiveSupport::Notifications.instrument("response.polaris_resource", :response => response) do
        PolarisResource::Response.new(response)
      end
    end

    def self.post(path, params = {})
      response = nil
      ActiveSupport::Notifications.instrument("request.polaris_resource", :method => :get, :path => build_path(path), :params => params) do
        response = Typhoeus::Request.post(build_path(path), build_params(params))
      end
      
      ActiveSupport::Notifications.instrument("response.polaris_resource", :response => response) do
        PolarisResource::Response.new(response)
      end
    end

    def self.put(path, params = {})
      response = nil
      ActiveSupport::Notifications.instrument("request.polaris_resource", :method => :get, :path => build_path(path), :params => params ) do
        response = Typhoeus::Request.put(build_path(path), build_params(params))
      end
      
      ActiveSupport::Notifications.instrument("response.polaris_resource", :response => response) do
        PolarisResource::Response.new(response)
      end
    end

    def self.build_path(path)
      "#{PolarisResource::Configuration.host}#{path}"
    end

    def self.build_params(params)
      params.empty? ? {} : { :params => params }
    end

  end

  # RequestCache middleware
  class RequestCache

    def initialize(app)
      @app = app
    end

    def call(env)
      PolarisResource::Request.cache.clear
      @app.call(env)
    end

  end
end