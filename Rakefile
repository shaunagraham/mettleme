# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

MettleMe::Application.load_tasks

task :default => 'autotest:spec'

namespace :db do
  namespace :migrate do
    desc 'Run rake db:migrate and rake db:test:prepare'
    task :prepare do
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:test:prepare'].invoke      
    end
  end
end

namespace :autotest do
  desc 'Run cucumber scenarios and specs with autotest'
  task :all do
    # Tell autotest to run cucumber scenarios as well as specs.
    #
    # See http://github.com/aslakhellesoy/cucumber/wiki/Autotest-Integration
    exec "export AUTOFEATURE=true; autotest"    
  end
  
  desc 'Run just specs with autotest'
  task :spec do
    exec 'autotest'
  end      
end
