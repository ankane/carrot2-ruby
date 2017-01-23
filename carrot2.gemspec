# -*- encoding: utf-8 -*-
require File.expand_path("../lib/carrot2/version", __FILE__)

Gem::Specification.new do |spec|
  spec.authors       = ["Andrew Kane"]
  spec.email         = ["andrew@chartkick.com"]
  spec.description   = "Ruby client for Carrot2"
  spec.summary       = "Ruby client for Carrot2"
  spec.homepage      = "https://github.com/ankane/carrot2"

  spec.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^exe/}).map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.name          = "carrot2"
  spec.require_paths = ["lib"]
  spec.version       = Carrot2::VERSION

  spec.add_dependency "builder"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
