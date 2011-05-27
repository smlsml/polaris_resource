module Polaris
  module Resource
    class Configuration

      class << self
        attr_writer :host, :hydra

        def host
          @host || raise(Polaris::Resource::ConfigurationError, "The request HOST has not been set. Please set the host using Polaris::Resource::Configuration.host = 'http://localhost:3000'")
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
        
      end

    end
  end
end