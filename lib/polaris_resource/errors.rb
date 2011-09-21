module PolarisResource
  # Occurs when a configuration issue occurs, like when the remote host is not set.
  class ConfigurationError < ::StandardError
  end

  # Occurs when a request from a remote host is made while PolarisResource::Configuration.allow_net_connect is set to false.
  class NetConnectNotAllowedError < ::StandardError
    attr_accessor :request
    def initialize(_request=nil)
      self.request= _request
    end
  end

  # Occurs when the remote host is unreachable.
  class RemoteHostConnectionFailure < ::StandardError
  end
  
  # Occurs when there is a server error resulting in a 500 response code
  class ServerError < ::StandardError
  end

  # Occurs when the requested resource returns a 404 error, indicating that it could not be found.
  class ResourceNotFound < ::StandardError
  end

  # Occurs when the typecast type is not one of the known values.
  class UnrecognizedTypeCastClass < ::StandardError
  end

  class InvalidResponseCode < ::StandardError
  end
end