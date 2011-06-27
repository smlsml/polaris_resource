module PolarisResource
  class RequestQueue

    def initialize
      @queue = []
    end

    def <<(request)
      @queue << request
    end

    def hydra
      Configuration.hydra
    end

    def run!
      uncached_queue.each { |request| hydra.queue(request) }
      hydra.run
      @queue.clear
    end

    def uncached_queue
      @queue.collect { |request| request if RequestCache.cache[request.cache_key].nil? }.compact
    end

  end
end