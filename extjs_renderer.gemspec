# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "extjs_renderer/version"

Gem::Specification.new do |s|
  s.name        = "extjs_renderer"
  s.version     = ExtjsRenderer::VERSION
  s.authors     = ["Mark H Winkler"]
  s.email       = ["mhwinkler@gmail.com"]
  s.homepage    = "https://github.com/mojomaze/extjs_renderer"
  s.summary     = "Rails 3 Renderer to send JSON compatible with Sencha Extjs 3+"
  s.description = "Rails 3 Renderer to send JSON compatible with Sencha Extjs 3+"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "rails", "3.0.10"
  s.add_development_dependency "capybara", ">= 0.4.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "will_paginate", "~> 3.0.0"
end