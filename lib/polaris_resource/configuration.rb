module Polaris
  module Resource
    class Configuration

      class << self
        attr_writer :host, :hydra

        def host
          @host || raise(Polaris::Resource::ConfigurationError, "The request HOST has not been set. Please set the host using Polaris::Resource::Configuration.host = 'http://www.example.com'")
        end

        def hydra
          @hydra ||= Typhoeus::Hydra.hydra
        end
        
        def enable_stubbing!
          @stubbing_enabled = true
        end
        
        def disable_stubbing!
          @stubbing_enabled = false
        end
        
        def stubbing_enabled?
          !!@stubbing_enabled
        end
        
        def allow_net_connect=(allowed)
          @net_connect_allowed = allowed
        end
        
        # Allows Net Connect by default
        allow_net_connect = true
        
        def allow_net_connect?
          !!@net_connect_allowed
        end
        
      end

    end
  end
end