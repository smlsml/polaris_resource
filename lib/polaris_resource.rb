# We are using Yalj::Ruby for its JSON parsing hotness.
require 'yajl/json_gem'

# Typhoeus is used for HTTP requests in parallel.
require 'typhoeus'

# ActiveModel provides validations, errors, naming...
require 'active_model'

# The bulk of the library consists of the Base class and its modules, the request/response wrappers, mocking, configuration, and errors.
module PolarisResource
  autoload :Base,          'polaris_resource/base'
  autoload :Configuration, 'polaris_resource/configuration'
  autoload :Mock,          'polaris_resource/mock'
  autoload :Relation,      'polaris_resource/relation'
  autoload :Request,       'polaris_resource/request'
  autoload :RequestQueue,  'polaris_resource/request_queue'
  autoload :RequestCache,  'polaris_resource/request_cache'
  autoload :Response,      'polaris_resource/response'
  autoload :TypeCaster,    'polaris_resource/type_caster'
  
  # MIXINS
  autoload :Associations,    'polaris_resource/mixins/associations'
  autoload :Attributes,      'polaris_resource/mixins/attributes'
  autoload :Conversion,      'polaris_resource/mixins/conversion'
  autoload :Finders,         'polaris_resource/mixins/finders'
  autoload :Introspection,   'polaris_resource/mixins/introspection'
  autoload :Persistence,     'polaris_resource/mixins/persistence'
  autoload :Reflections,     'polaris_resource/mixins/reflections'
  autoload :RequestHandling, 'polaris_resource/mixins/request_handling'
  autoload :ResponseParsing, 'polaris_resource/mixins/response_parsing'
  
  # ERROR CLASSES
  autoload :ConfigurationError,          'polaris_resource/errors'
  autoload :NetConnectNotAllowedError,   'polaris_resource/errors'
  autoload :RemoteHostConnectionFailure, 'polaris_resource/errors'
  autoload :ResourceNotFound,            'polaris_resource/errors'
  autoload :UnrecognizedProperty,        'polaris_resource/errors'
  autoload :UnrecognizedTypeCastClass,   'polaris_resource/errors'
end

# Associations for application objects, typically ActiveRecord, to resource
module PolarisClient
  autoload :Associations,             'polaris_client/associations'
  autoload :LogSubscriber,            'polaris_client/log_subscriber'
end

# Railtie
require 'polaris_client/railtie' if defined?(Rails)

# There are some Typhoeus patches contained here.
require 'ext/typhoeus'
