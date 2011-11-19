# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "extjs_renderer"
  s.summary = "Rails 3 Renderer to send JSON compatible with Sencha Extjs 3+"
  s.description = "Rails 3 Renderer to send JSON compatible with Sencha Extjs 3+"
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version = "0.0.1"
end