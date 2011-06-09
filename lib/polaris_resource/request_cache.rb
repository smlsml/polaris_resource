module PolarisResource
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