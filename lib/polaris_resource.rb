$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'yajl/json_gem'
require 'typhoeus'
require 'active_support/time'
require 'active_support/core_ext/numeric/time'
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/string/inflections'
require 'active_support/inflections'

require 'polaris_resource/base'
require 'polaris_resource/configuration'
require 'polaris_resource/errors'
require 'polaris_resource/mock'
require 'polaris_resource/request'
require 'polaris_resource/response'

require 'ext/typhoeus'