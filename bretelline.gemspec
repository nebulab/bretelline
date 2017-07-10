# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bretelline/version"

Gem::Specification.new do |spec|
  spec.name          = "bretelline"
  spec.version       = Bretelline::VERSION
  spec.authors       = ["Matteo Latini"]
  spec.email         = ["matteolatini@nebulab.it"]

  spec.summary       = 'A Rails::AppBuilder gem for Nebulab.'
  spec.description   = 'This is a gem that stores all the templates for Nebulab Rails applications.'
  spec.homepage      = 'https://github.com/nebulab/bretelline'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', Bretelline::RAILS_VERSION

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
