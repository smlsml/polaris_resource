module Polaris
  module Resource
    class ConfigurationError < ::StandardError
    end
    
    class NetConnectNotAllowedError < ::StandardError
    end
  end
end