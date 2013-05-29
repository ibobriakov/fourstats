# RVM

#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'default'
set :rvm_type, :user

# Bundler

require "bundler/capistrano"

# General
default_run_options[:pty] = true
set :application, "foursquare"
set :user, "victor"
set :scm_passphrase, "victorse"

set :deploy_to, "/home/victor/sites/#{application}"
set :deploy_via, :copy

set :use_sudo, true

# Git

set :scm, :git
set :repository,  "~/sites/foursquare_app/.git"
set :branch, "master"

# VPS

#role :web, "151.236.217.89"
#role :app, "151.236.217.89"
#role :db,  "151.236.217.89", :primary => true
#role :db,  "151.236.217.89"
server "151.236.217.89", :app, :web, :db, :primary => true
# Passenger

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end