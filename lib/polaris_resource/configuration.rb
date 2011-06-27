module PolarisResource
  class Configuration

    class << self

      # Sets and gets the remote host service domain.
      # The domain must be set before any requests can be made.
      attr_writer :host
      def host
        @host || raise(PolarisResource::ConfigurationError, "The request HOST has not been set. Please set the host using PolarisResource::Configuration.host = 'http://www.example.com'")
      end

      # Links to the underlying libcurl request pool.
      # Allows for concurrent requests.
      def hydra
        Typhoeus::Hydra.hydra
      end

      def hydra=(hydra)
        Typhoeus::Hydra.hydra = hydra
      end

      # Handles the default logger that is used by the LogSubscriber
      def logger
        @logger ||= ::Logger.new(STDOUT)
      end

      def logger=(logger)
        @logger = logger
      end

      # Can be set or unset to allow for test suite mocking.
      def allow_net_connect=(allowed)
        Typhoeus::Hydra.allow_net_connect = allowed
      end

      # Allow net connections by default.
      allow_net_connect = true

      def allow_net_connect?
        Typhoeus::Hydra.allow_net_connect?
      end

    end

  end
end