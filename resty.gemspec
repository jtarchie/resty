# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resty/version'

Gem::Specification.new do |gem|
  gem.name          = "resty"
  gem.version       = Resty::VERSION
  gem.authors       = ["JT Archie"]
  gem.email         = ["jtarchie@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rack"
  gem.add_dependency "activesupport"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rack-test"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "activerecord"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rails"
end
