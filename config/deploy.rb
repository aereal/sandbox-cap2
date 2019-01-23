# frozen_string_literal: true

module Stage
  DEV = 'dev'
  STAGING = 'staging'
  PRODUCTION = 'production'

  def self.all
    [DEV, STAGING, PRODUCTION]
  end
end

set :stages, Stage.all
set :default_stage, Stage::STAGING

require 'capistrano/ext/multistage'

set :application, "set your application name here"
set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :maintenance do
  desc 'Turn ON maintenance mode'
  task :on do
    puts "Make #{fetch(:application)} maintenance ON"
  end

  desc 'Turn off maintenance mode'
  task :off do
    puts "Bye maintenance"
    puts "Make #{fetch(:application)} maintenance off"
  end
end
