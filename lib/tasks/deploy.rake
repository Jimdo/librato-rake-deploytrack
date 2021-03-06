require 'librato/metrics'

user            = ENV['LIBRATO_USER'] || ENV['LIBRATO_METRICS_USER']
token           = ENV['LIBRATO_TOKEN'] || ENV['LIBRATO_METRICS_TOKEN']
source          = ENV['LIBRATO_SOURCE'] || ENV['LIBRATO_METRICS_SOURCE'] || 'production'
file            = ENV['LIBRATO_DEPLOY_FILE'] ||'librato-rake-deploytrack-deploy-id'
deployment_name = ENV['LIBRATO_DEPLOYMENT_ANNOTATION'] && ENV['LIBRATO_DEPLOYMENT_ANNOTATION'].to_sym || :deployments

Librato::Metrics.authenticate user, token

namespace :librato do
  namespace :deploy do

    desc "Mark a deployment start in librato metrics annotations streams"
    task :start, :title, :description do |task, args|
      r = Librato::Metrics.annotate deployment_name, args[:title], :source => source, :start_time => Time.now.to_i, :description => args[:description]
      File.open(file, 'w') { |file| file.write r['id'] }
    end

    desc "Mark a previously started (rake librato:deploy:start) deploy as finished in librato metrics annotations streams"
    task :end do
      id = File.read(file).to_i
      annotator = Librato::Metrics::Annotator.new
      annotator.update_event deployment_name, id, :end_time => Time.now.to_i
      File.delete(file) 
    end

    task :list do
      annotator = Librato::Metrics::Annotator.new
      p annotator.fetch_event deployment_name, File.read(file).to_i if File.exists?(file)
      p annotator.fetch deployment_name
    end

  end
end
