# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gumby-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "gumby-rails"
  gem.version       = Gumby::Rails::VERSION
  gem.authors       = ["Fábio Luiz Nery de Miranda"]
  gem.email         = ["fabio@miranti.net.br"]
  gem.description   = %q{A rails gem for http://gumbyframework.com assets}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/fabiolnm/gumby-rails"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "jquery-rails"
  gem.add_development_dependency "modernizr-rails"
end
