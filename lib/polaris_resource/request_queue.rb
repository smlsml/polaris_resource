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
    end
    
    def uncached_queue
      @queue.collect { |request| request if RequestCache.cache[[request.path, request.params]].nil? }.compact
    end
    
  end
end