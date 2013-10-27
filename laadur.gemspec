# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'laadur/version'
include Laadur

Gem::Specification.new do |spec|
  spec.name          = "laadur"
  spec.version       = Laadur.VERSION
  spec.authors       = ["Nikita Nikitin"]
  spec.email         = ["berozzy@gmail.com"]
  spec.description   = "Helps to simplify workflow"
  spec.summary       = ""
  spec.homepage      = "http://github.com/rozzy/laadur"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["laadur"] #spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
