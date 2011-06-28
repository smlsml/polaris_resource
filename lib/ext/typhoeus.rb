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

    def response_from_easy(easy, request)
      PolarisResource::Response.new(
        :code                => easy.response_code,
        :headers             => easy.response_header,
        :body                => easy.response_body,
        :time                => easy.total_time_taken,
        :start_transfer_time => easy.start_transfer_time,
        :app_connect_time    => easy.app_connect_time,
        :pretransfer_time    => easy.pretransfer_time,
        :connect_time        => easy.connect_time,
        :name_lookup_time    => easy.name_lookup_time,
        :effective_url       => easy.effective_url,
        :curl_return_code    => easy.curl_return_code,
        :curl_error_message  => easy.curl_error_message,
        :request             => request
      )
    end
    private :response_from_easy

  end
end