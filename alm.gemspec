# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alm/version'

Gem::Specification.new do |s|
  s.name        = 'alm'
  # s.version     = alm::VERSION
  s.version     = '0.1.0'
  s.date        = '2014-12-04'
  s.summary     = "alm client for Ruby"
  s.description = "alm client for Ruby adfad"
  s.authors     = ["Scott Chamberlain"]
  s.email       = 'myrmecocystus@gmail.com'
  s.files       = ["lib/alm.rb"]
  s.homepage    = 'http://github.com/sckott/alm'
  s.licenses    = 'MIT'
  s.require_paths = ["lib"]
  s.bindir      = 'bin'
  s.executables = ['alm']
  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake", '~> 0'
  s.add_runtime_dependency 'httparty', '~> 0.12'
  s.add_runtime_dependency 'thor', '~> 0.18'
  s.add_runtime_dependency 'json', '~> 1.8'
  s.add_runtime_dependency 'launchy', '~> 2.4', '>= 2.4.2'
end
