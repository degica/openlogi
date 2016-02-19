# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openlogi/version'

Gem::Specification.new do |spec|
  spec.name          = "openlogi"
  spec.version       = Openlogi::VERSION
  spec.authors       = ["Chris Salzberg"]
  spec.email         = ["csalzberg@degica.com"]

  spec.summary       = %q{Unofficial ruby wrapper for OpenLogi API}
  spec.description   = %q{Unofficial ruby wrapper for OpenLogi API}
  spec.homepage      = "https://openlogi.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "typhoeus", "~> 1.0.1"
  spec.add_dependency "activesupport"
  spec.add_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "guard-rspec"
end
