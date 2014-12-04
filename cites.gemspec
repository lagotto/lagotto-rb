# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lagotto/version'

Gem::Specification.new do |s|
  s.name        = 'lagotto'
  s.version     = lagotto::VERSION
  s.date        = '2014-12-04'
  s.summary     = "Lagotto client for Ruby"
  s.description = "Lagotto client for Ruby"
  s.authors     = ["Scott Chamberlain"]
  s.email       = 'myrmecocystus@gmail.com'
  s.files       = ["lib/lagotto.rb"]
  s.homepage    = 'http://github.com/sckott/lagotto'
  s.licenses    = 'MIT'
  s.require_paths = ["lib"]
  s.bindir      = 'bin'
  s.executables = ['alm']
  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake"
  s.add_runtime_dependency 'httparty', '~> 0.12'
  s.add_runtime_dependency 'thor', '~> 0.18'
  s.add_runtime_dependency 'json', '~> 1.8'
  s.add_runtime_dependency 'launchy', '~> 2.4.2'
end
