# We are using Yalj::Ruby for its JSON parsing hotness.
require 'yajl/json_gem'

# Typhoeus is able to do some pretty cool stuff with its Hydra parallel request infrastructure.
require 'typhoeus'

# ActiveModel to support naming, validations, errors, and such...
require 'active_model'

# I almost feel like a lot of this should just be in stdlib by now.
require 'active_support/time'
require 'active_support/core_ext/numeric/time'
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/string/inflections'
require 'active_support/inflections'
require 'active_support/core_ext/array/extract_options'
require 'active_support/notifications'
require 'active_support/log_subscriber'
require 'active_support/basic_object'

# The bulk of the library consists of the Base class and its modules, the request/response wrappers, mocking, configuration, and errors.
require 'polaris_resource/base'
require 'polaris_resource/configuration'
require 'polaris_resource/errors'
require 'polaris_resource/mock'
require 'polaris_resource/request'
require 'polaris_resource/response'
require 'polaris_resource/type_caster'
require 'polaris_resource/associations'

# Associations for application objects, typically ActiveRecord, to resource
require 'polaris_client/associations'
require 'polaris_client/log_subscriber'
require 'polaris_client/railtie' if defined?(Rails)

# There are some Typhoeus patches contained here.
require 'ext/typhoeus'
