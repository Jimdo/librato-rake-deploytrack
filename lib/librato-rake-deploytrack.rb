module Deploytrack

  class DeploytrackRailtie < Rails::Railtie
    gem_dir = File.dirname __FILE__
    rake_tasks do
      Dir.glob("#{gem_dir}/tasks/*.rake").each { |r| load r }
    end
  end
end