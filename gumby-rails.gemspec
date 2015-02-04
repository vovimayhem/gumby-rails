# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gumby/rails/version"

Gem::Specification.new do |s|
  s.name          = "gumby-rails"
  s.version       = Gumby::Rails::VERSION
  s.authors       = ["Fábio Luiz Nery de Miranda"]
  s.email         = ["fabio@miranti.net.br"]
  s.description   = %q{A rails gem for http://gumbyframework.com assets}
  s.summary       = %q{}
  s.homepage      = "https://github.com/fabiolnm/gumby-rails"

  #s.files         = `git ls-files`.split($/)
  #s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  # s.add_runtime_dependency 'activesupport'#, ['>= 3', '< 5']
  s.add_dependency 'rails', ">= 3"

  s.add_dependency "sprockets",  ">= 2.12.0"

  # Problems with "sass-rails" version "4.0.1"...
  s.add_dependency "sass-rails", ">= 4.0.3"

  s.add_dependency "jquery-rails"
  s.add_dependency "modernizr-rails"
  s.add_dependency "compass-rails"
  s.add_dependency "modular-scale",  ">= 1.0.6"

  s.add_development_dependency "thor"



end
