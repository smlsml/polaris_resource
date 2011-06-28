module PolarisResource
  class RequestQueue

    def initialize(app)
      @app = app
    end

    def call(env)
      self.class.queue.clear
      @app.call(env)
    end

    class << self

      def enqueue(request)
        queue << request
      end

      def queue
        @queue ||= []
      end

      def uncached_queue
        queue.collect { |request| request if RequestCache.cache[request.cache_key].nil? }.compact
      end

      def hydra
        Configuration.hydra
      end

      def run!
        uncached_queue.each { |request| hydra.queue(request) }
        hydra.run
        queue.clear
      end

      def has_request?(request)
        queue.include?(request)
      end

    end

  end
end