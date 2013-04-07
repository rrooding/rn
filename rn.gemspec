# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rn/version'

Gem::Specification.new do |gem|
  gem.name          = "rn"
  gem.version       = Rn::VERSION
  gem.authors       = ["Ralph Rooding"]
  gem.email         = ["ralph@izerion.com"]
  gem.description   = %q{Rails validations for Belgian Government Registration Numbers (Rijksregisternummer)}
  gem.summary       = %q{Rails validations for Belgian Government Registration Numbers (Rijksregisternummer)}
  gem.homepage      = "https://github.com/rrooding/rn"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
