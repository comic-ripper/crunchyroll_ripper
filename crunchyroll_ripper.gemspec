# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crunchyroll_ripper/version'

Gem::Specification.new do |spec|
  spec.name          = "crunchyroll_ripper"
  spec.version       = CrunchyrollRipper::VERSION
  spec.authors       = ["Eric Nelson"]
  spec.email         = ["eric@clean-logix.com"]
  spec.summary       = %q{Crunchyroll manga api ripper}
  spec.description   = %q{Downloads crunchyroll manga}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rest-client'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">=3.0.0.beta2"
  spec.add_development_dependency "webmock", "~> 1.18"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "simplecov"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"

  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
