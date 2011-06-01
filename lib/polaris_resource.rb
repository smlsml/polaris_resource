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

# The bulk of the library consists of the Base class and its modules, the request/response wrappers, mocking, configuration, and errors.
require 'polaris_resource/base'
require 'polaris_resource/configuration'
require 'polaris_resource/errors'
require 'polaris_resource/mock'
require 'polaris_resource/request'
require 'polaris_resource/response'
require 'polaris_resource/type_caster'

# There are some Typhoeus patches contained here.
require 'ext/typhoeus'