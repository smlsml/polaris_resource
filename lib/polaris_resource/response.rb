module PolarisResource
  class Response

    def initialize(response_or_attributes = {}, cached = nil)
      @cached = cached
      @response = if Typhoeus::Response === response_or_attributes
        response_or_attributes
      else
        Typhoeus::Response.new(response_or_attributes)
      end
    end

    def cached?
      !!@cached
    end

    def respond_to?(method, include_private = false)
      methods.include?(method) || @response.respond_to?(method.to_sym)
    end

    def method_missing(m, *args, &block)
      @response.send(m.to_sym, *args, &block) if @response.respond_to?(m.to_sym)
    end

  end
end