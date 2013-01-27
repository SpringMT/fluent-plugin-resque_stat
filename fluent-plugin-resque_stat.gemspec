# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-resque_stat"
  gem.version       = "0.0.1"
  gem.authors       = ["Spring_MT"]
  gem.email         = ["today.is.sky.blue.sky@gmail.com"]
  gem.summary       = %q{Fluent input plugin for Resque info}
  gem.homepage      = "https://github.com/SpringMT/fluent-plugin-resque_stat"

  gem.rubyforge_project = "fluent-plugin-resque_stat"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "resque", "~> 1.22"
  gem.add_dependency "fluentd"
  gem.description = <<description
Fluent input plugin for Resque info
description
end
