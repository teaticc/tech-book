# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'tech-book'
set :repo_url, 'git@github.com:teaticc/tech-book.git'

set :rbenv_ruby, "2.3.1"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/tbook_developer/tech-book'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads', 'public/assets')
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for default_env is {}
set :default_env, {
  ACCESS_KEY_ID: ENV["ACCESS_KEY_ID"],
  SECRET_ACCESS_KEY: ENV["SECRET_ACCESS_KEY"],
  SECRET_KEY_BASE: ENV["SECRET_KEY_BASE"],
  TECH_BOOK_DATABASE_PASSWORD: ENV['TECH_BOOK_DATABASE_PASSWORD'],
  DB_HOST: ENV['DB_HOST']
  }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :migration_role, :app

set :conditionally_migrate, true

set :log_level, :debug

namespace :deploy do
  after :publishing, :restart

  desc "Restart application"
  task :restart do
    invoke "unicorn:restart"
  end
end
