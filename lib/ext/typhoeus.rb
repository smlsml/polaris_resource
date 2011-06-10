module Typhoeus
  class Hydra
    module ConnectOptions

      def check_allow_net_connect_with_error_wrapping!(request)
        check_allow_net_connect_without_error_wrapping!(request)
      rescue Typhoeus::Hydra::NetConnectNotAllowedError => ex
        raise PolarisResource::NetConnectNotAllowedError, ex.message
      end
      private :check_allow_net_connect_with_error_wrapping!

      alias_method :check_allow_net_connect_without_error_wrapping!, :check_allow_net_connect!
      alias_method :check_allow_net_connect!, :check_allow_net_connect_with_error_wrapping!

    end
  end
end