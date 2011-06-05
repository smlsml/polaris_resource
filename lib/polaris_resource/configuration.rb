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
        @logger ||= begin
          logger = ActiveSupport::BufferedLogger.new(STDOUT)
          logger.level = ActiveSupport::BufferedLogger.const_get(ActiveSupport::BufferedLogger::INFO)
          logger
        rescue StandardError => e
          logger = ActiveSupport::BufferedLogger.new(STDERR)
          logger.level = ActiveSupport::BufferedLogger::WARN
          logger.warn(
            "PolarisResource Error: Unable to access log file. Please ensure that #{path} exists and is chmod 0666. " +
            "The log level has been raised to WARN and the output directed to STDERR until the problem is fixed."
          )
          logger
        end
      end
      
      def logger=(_logger)
        @logger = _logger
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