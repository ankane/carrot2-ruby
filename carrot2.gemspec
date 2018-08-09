
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "carrot2/version"

Gem::Specification.new do |spec|
  spec.name          = "carrot2"
  spec.version       = Carrot2::VERSION
  spec.summary       = "Ruby client for Carrot2"
  spec.homepage      = "https://github.com/ankane/carrot2"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.2"

  spec.add_dependency "builder"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
