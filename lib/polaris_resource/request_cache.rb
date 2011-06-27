module PolarisResource
  class RequestCache

    def initialize(app)
      @app = app
    end

    def call(env)
      self.class.cache.clear
      @app.call(env)
    end

    def self.cache
      @cache ||= {}
    end

  end
end