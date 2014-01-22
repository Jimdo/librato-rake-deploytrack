module Deploytrack

  def self.load_rake
    gem_dir = File.dirname __FILE__
    Dir.glob("#{gem_dir}/tasks/*.rake").each { |r| load r }
  end

  if defined?(Rails::Railtie) == 'constant' && Rails::Railtie.class == Class
    class DeploytrackRailtie < Rails::Railtie
      rake_tasks { Deploytrack::load_rake }
    end
  else
    load_rake
  end

end
