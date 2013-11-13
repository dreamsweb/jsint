# encoding : utf-8
# A Capistrano deploy configuration file for non-Rails applications
set :application, "jsin"

# Use git, set the repo
set :repository,  "git@github.com:ex/jsin.git"
set :scm, :git
set :branch, "master"

# server roles
role :app, "ex.com"
role :web, "ex.com"
role :db, "ex.com", primary: true

# configure user and folders
set :user, "ex_admin"
set :use_sudo, false
set :deploy_to, "/var/www/#{user}/data/www/#{application}"
set :keep_releases, 5

default_run_options[:shell] = '/bin/bash --login'

# ==================================================================================================
# deploy tasks
# ==================================================================================================
namespace :deploy do
  # passenger restart
  task :start do ; end
  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  # This will make sure that Capistrano doesn't try to run rake:migrate 
  # (this is not a Rails project!)
  task :cold do
    deploy.update
    deploy.start
  end
end
# after "deploy:restart", "deploy:cleanup"

# ==================================================================================================
# RVM, Ruby, gems
# ==================================================================================================
set :rvm_type, :system
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")

require "rvm/capistrano"
require "bundler/capistrano"