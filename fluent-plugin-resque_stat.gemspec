# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent-plugin-resque-stat/version'

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-resque-stat"
  gem.version       = "0.0.1"
  gem.authors       = ["Spring_MT"]
  gem.email         = ["today.is.sky.blue.sky@gmail.com"]
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/SpringMT/"

  gem.rubyforge_project = "fluent-plugin-resque-stat"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency = "resque", "~> 1.22"

  gem.description = <<description

description
end
