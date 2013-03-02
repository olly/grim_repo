# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grim_repo/version'

Gem::Specification.new do |spec|
  spec.name          = "grim_repo"
  spec.version       = GrimRepo::VERSION
  spec.authors       = ["Olly Legg"]
  spec.email         = ["olly@51degrees.net"]
  spec.summary       = %q{A Ruby wrapper for the GitHub v3 API.}
  spec.description   = %q{An idiomatic Ruby wrapper for the GitHub v3 API – for humans, not computers.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
