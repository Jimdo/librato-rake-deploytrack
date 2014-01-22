Gem::Specification.new do |s|
  s.name        = 'librato-rake-deploytrack'
  s.version     = '0.0.2'
  s.date        = '2013-01-22'
  s.summary     = "Rake tasks to keep track of your deploys in Librato Metrics, using the Annotationstreams!"
  s.description = s.summary
  s.authors     = ["Ole Michaelis"]
  s.email       = 'Ole.Michaelis@googlemail.com'
  s.files       = 'lib/librato-rake-deploytrack.rb'
  s.homepage    = 'http://rubygems.org/gems/librato-rake-deploytrack'
  s.license     = 'MIT'

  s.add_runtime_dependency("rake")
  s.add_runtime_dependency("librato-metrics")
end