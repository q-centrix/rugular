# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rugular/version'

Gem::Specification.new do |spec|
  spec.name          = 'rugular'
  spec.version       = Rugular::VERSION
  spec.authors       = ['Nicholas Shook']
  spec.email         = ['nshook@q-centrix.com']
  spec.summary       = %q{Rugular - a ruby scaffolding framework for AngularJS}
  spec.homepage      = 'http://rugular.info'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'actionview',    '~> 4'
  spec.add_runtime_dependency 'guard',         '~> 2'
  spec.add_runtime_dependency 'guard-compat',  '~> 1'
  spec.add_runtime_dependency 'coffee-script', '~> 2'
  spec.add_runtime_dependency 'haml',          '~> 4'
  spec.add_runtime_dependency 'sass',          '~> 3'
  spec.add_runtime_dependency 'uglifier',      '~> 2'
  spec.add_runtime_dependency 'foreman',       '~> 0'
  spec.add_runtime_dependency 'thor',          '~> 0'
  spec.add_runtime_dependency 'bourbon',       '~> 4'
  spec.add_runtime_dependency 'neat',          '~> 1'

  spec.add_development_dependency 'aruba',  '~> 0'
  spec.add_development_dependency 'byebug', '~> 3'
  spec.add_development_dependency 'pry',    '~> 0'
  spec.add_development_dependency 'rake',   '~> 10'
end
