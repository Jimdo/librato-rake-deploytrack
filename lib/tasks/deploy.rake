require 'librato/metrics'

user   = ENV['LIBRATO_USER'] || ENV['LIBRATO_METRICS_USER']
token  = ENV['LIBRATO_TOKEN'] || ENV['LIBRATO_METRICS_TOKEN']
source = ENV['LIBRATO_SOURCE'] || ENV['LIBRATO_METRICS_SOURCE'] || 'production'
file   = ENV['LIBRATO_DEPLOY_FILE'] ||'librato-rake-deploytrack-deploy-id'

Librato::Metrics.authenticate user, token

namespace :librato do
  namespace :deploy do

    desc "Mark a deployment start in librato metrics annotations streams"
    task :start, :name, :description do |task, args|
      r = Librato::Metrics.annotate :deployments, args[:name], :source => source, :start_time => Time.now.to_i, :description => args[:description]
      File.open(file, 'w') { |file| file.write r['id'] }
    end

    desc "Mark a previously started (rake librato:deploy:start) deploy as finished in librato metrics annotations streams"
    task :end do
      id = File.read(file).to_i
      annotator = Librato::Metrics::Annotator.new
      annotator.update_event :deployments, id, :end_time => Time.now.to_i
      File.delete(file) 
    end

#    desc "List annotations"
#    task :list do
#      annotator = Librato::Metrics::Annotator.new
#      p annotator.fetch_event :deployments, File.read(file).to_i if File.exists?(file)
#      p annotator.fetch :deployments
#    end

  end
end
