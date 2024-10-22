require_relative "lib/carrot2/version"

Gem::Specification.new do |spec|
  spec.name          = "carrot2"
  spec.version       = Carrot2::VERSION
  spec.summary       = "Ruby client for Carrot2"
  spec.homepage      = "https://github.com/ankane/carrot2-ruby"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 3.1"
end
