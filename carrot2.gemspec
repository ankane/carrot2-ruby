# -*- encoding: utf-8 -*-
require File.expand_path('../lib/carrot2/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Kane"]
  gem.email         = ["acekane1@gmail.com"]
  gem.description   = %q{Ruby client for Carrot2}
  gem.summary       = %q{Ruby client for Carrot2}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "carrot2"
  gem.require_paths = ["lib"]
  gem.version       = Carrot2::VERSION

  gem.add_dependency "builder"
  gem.add_dependency "rest-client"
end
