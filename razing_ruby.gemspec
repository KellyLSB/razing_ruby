# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'razing_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "razing_ruby"
  spec.version       = RazingRuby::VERSION
  spec.authors       = ["Kelly Becker"]
  spec.email         = ["kellylsbkr@gmail.com"]
  spec.summary       = %q{Don't raise ruby... Raze ruby and find that bug}
  spec.description   = %q{Extends system level debug tools to help you find bugs both in development and production}
  spec.homepage      = "http://kellybecker.me"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
