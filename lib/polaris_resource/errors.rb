module PolarisResource
  class ConfigurationError < ::StandardError
  end

  class NetConnectNotAllowedError < ::StandardError
  end
  
  class RemoteHostConnectionFailure < ::StandardError
  end

  class ResourceNotFound < ::StandardError
  end
  
  class UnrecognizedProperty < ::StandardError
  end
  
  class UnrecognizedTypeCastClass < ::StandardError
  end
end