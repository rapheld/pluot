# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pluot/version'

Gem::Specification.new do |spec|
  spec.name          = "pluot"
  spec.version       = Pluot::VERSION
  spec.authors       = ["Nathan Rapheld"]
  spec.email         = ["nathan@rapheld.org"]
  spec.summary       = "Wild Apricot API Client Wrapper"
  spec.description   = ""
  spec.homepage      = "https://github.com/rapheld/pluot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "faraday", "~> 0.9.0"
  spec.add_runtime_dependency "faraday_middleware", "~> 0.9.0"
end
