module Typhoeus
  class Hydra
    
    def handle_request_with_net_connect_check(request, response, live_request = true)
      if Polaris::Resource::Configuration.allow_net_connect? || Polaris::Resource::Mock.matches?(request)
        handle_request_without_net_connect_check(request, response, live_request)
      else
        raise Polaris::Resource::NetConnectNotAllowedError, "Real HTTP connections are disabled. Unregistered request: #{request.method.to_s.upcase} #{request.url}"
      end
    end
    private :handle_request_with_net_connect_check
    
    alias_method :handle_request_without_net_connect_check, :handle_request
    alias_method :handle_request, :handle_request_with_net_connect_check
    
  end
end