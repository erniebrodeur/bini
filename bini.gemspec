# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bini/version'

Gem::Specification.new do |gem|
  gem.name          = "bini"
  gem.version       = Bini::VERSION
  gem.authors       = ["Ernie Brodeur"]
  gem.email         = ["ebrodeur@ujami.net"]
  gem.description   = "Bini needs no description."
  gem.summary       = "Bini is a gem that helps me build CLI tools.  It's not thor, trollop, or any of the other major frameworks.  It makes lots and lots of assumptions.  It's probably not for you."
  gem.homepage      = "https://github.com/erniebrodeur/bini"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "yajl-ruby"
  gem.add_runtime_dependency "sys-proctable"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "pry"
end
