module PolarisResource
  class Response
    
    def initialize(response_or_attributes = {})
      if Typhoeus::Response === response_or_attributes
        @response = response_or_attributes
      else
        @response = Typhoeus::Response.new(response_or_attributes)
      end
    end
    
    def respond_to?(method)
      methods.include?(method) ||
        @response.respond_to?(method.to_sym)
    end
    
    def method_missing(m, *args, &block)
      @response.send(m.to_sym, *args, &block) if @response.respond_to?(m.to_sym)
    end
    
  end
end