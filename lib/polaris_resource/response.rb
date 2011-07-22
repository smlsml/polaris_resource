module PolarisResource
  class Response < Typhoeus::Response

    def initialize(params = {}, cached = false)
      super(params)
      @cached = cached
    end

    def cached?
      !!@cached.tap do
        @cached = tagged_for_caching?
      end
    end
    
    def tag_for_caching!
      @tagged_for_caching = true
    end
    
    def tagged_for_caching?
      @tagged_for_caching ||= false
    end

  end
end