module PolarisResource
  class Configuration

    class << self
      attr_writer :host

      def host
        @host || raise(PolarisResource::ConfigurationError, "The request HOST has not been set. Please set the host using PolarisResource::Configuration.host = 'http://www.example.com'")
      end

      def hydra
        Typhoeus::Hydra.hydra
      end

      def hydra=(hydra)
        Typhoeus::Hydra.hydra = hydra
      end
      
      def logger
        @logger ||= ::Logger.new(STDOUT)
      end
      
      def logger=(logger)
        @logger = logger
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
        Typhoeus::Hydra.allow_net_connect = allowed
      end

      # allow net connections by default
      allow_net_connect = true

      def allow_net_connect?
        Typhoeus::Hydra.allow_net_connect?
      end

    end

  end
end