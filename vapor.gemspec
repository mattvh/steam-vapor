# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vapor/version'

Gem::Specification.new do |spec|
	
	spec.name          = "vapor"
	spec.version       = Vapor::VERSION
	spec.authors       = ["redwallhp"]
	spec.description   = "CLI Steam client"
	spec.summary       = "A command-line client for Steam and Source servers"
	spec.homepage      = "http://github.com/redwallhp"
	spec.license       = "GPLv2"

	spec.files         = `git ls-files`.split($/)
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler", "~> 1.3"
	spec.add_development_dependency "rake"

	s.add_runtime_dependency "thor"
	s.add_runtime_dependency "user_config"
	s.add_runtime_dependency "steam-condenser"

end
