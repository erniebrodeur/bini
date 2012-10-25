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
  gem.summary       = "No really, it doesn't."
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "coderay"
  gem.add_runtime_dependency "couchrest"
  gem.add_runtime_dependency "couchrest_model"
  gem.add_runtime_dependency "yajl-ruby"
  gem.add_runtime_dependency "datamapper"
  gem.add_runtime_dependency "datamapper"
  gem.add_runtime_dependency "dm-types"
  gem.add_runtime_dependency "dm-sqlite-adapter"
  gem.add_runtime_dependency "sys-proctable"
  gem.add_runtime_dependency "pry"
  gem.add_development_dependency "net-scp"
end
