# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "polaris_resource"
  gem.homepage    = "http://github.com/ryanmoran/polaris_resource"
  gem.license     = "MIT"
  gem.summary     = %Q{RESTful API Client}
  gem.description = %Q{RESTful API Client}
  gem.email       = "ryan.moran@gmail.com"
  gem.authors     = ["Ryan Moran"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern   = 'spec/**/*_spec.rb'
  spec.rcov_opts = "--exclude osx\/objc,gems\/,spec\/"
  spec.rcov      = true
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new

desc "Builds the documentation using Rocco"
task :doc do
  system 'rocco -o doc -t doc/layout.mustache lib/*.rb lib/**/*.rb lib/**/**/*.rb'
end
