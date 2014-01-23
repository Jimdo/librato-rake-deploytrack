Gem::Specification.new do |s|
  s.name        = 'librato-rake-deploytrack'
  s.version     = '0.0.3'
  s.date        = '2013-01-22'
  s.summary     = "Rake tasks to keep track of your deploys in Librato Metrics, using the Annotationstreams!"
  s.description = s.summary + " Librato Rake Deploytrack is a collection of raketasks. So you should be able to include them in every application utilizing rake."
  s.authors     = ["Ole Michaelis"]
  s.email       = 'Ole.Michaelis@googlemail.com'
  s.files       = Dir['lib/*.rb'] + Dir['lib/tasks/*/.rake']
  s.homepage    = 'https://github.com/Jimdo/librato-rake-deploytrack'
  s.license     = 'MIT'

  s.add_runtime_dependency "rake", "~> 10.1"
  s.add_runtime_dependency "librato-metrics", "~> 1.3"
end