# We are using Yalj::Ruby for its JSON parsing hotness.
require 'yajl/json_gem'

# The bulk of the library consists of the Base class and its modules, the request/response wrappers, mocking, configuration, and errors.
module PolarisResource
  autoload :Associations,  'polaris_resource/associations'
  autoload :Attributes,    'polaris_resource/attributes'
  autoload :Base,          'polaris_resource/base'
  autoload :Configuration, 'polaris_resource/configuration'
  autoload :Finders,       'polaris_resource/finders'
  autoload :Mock,          'polaris_resource/mock'
  autoload :Persistence,   'polaris_resource/persistence'
  autoload :Relation,      'polaris_resource/relation'
  autoload :Request,       'polaris_resource/request'
  autoload :RequestCache,  'polaris_resource/request_cache'
  autoload :Response,      'polaris_resource/response'
  autoload :TypeCaster,    'polaris_resource/type_caster'
  
  # ERROR CLASSES
  autoload :ConfigurationError,        'polaris_resource/errors'
  autoload :NetConnectNotAllowedError, 'polaris_resource/errors'
  autoload :ResourceNotFound,          'polaris_resource/errors'
  autoload :UnrecognizedProperty,      'polaris_resource/errors'
  autoload :UnrecognizedTypeCastClass, 'polaris_resource/errors'
end

# Associations for application objects, typically ActiveRecord, to resource
module PolarisClient
  autoload :Associations,  'polaris_client/associations'
  autoload :LogSubscriber, 'polaris_client/log_subscriber'
end

# Railtie
require 'polaris_client/railtie' if defined?(Rails)

# There are some Typhoeus patches contained here.
require 'ext/typhoeus'
