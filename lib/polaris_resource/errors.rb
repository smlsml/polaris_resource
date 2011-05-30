module PolarisResource
  class ConfigurationError < ::StandardError
  end

  class NetConnectNotAllowedError < ::StandardError
  end

  class RecordNotFound < ::StandardError
  end
end