# config valid only for Capistrano 3.1
lock '3.2.1'

set :pty, true

set :application, 'structure_research'
set :repo_url, 'git@bitbucket.org:fishermenlabsteam/structure-research-db-project.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :deploy_via, :remote_cache

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{tmp/pids tmp/sockets log}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


# RVM
set :rvm_type, :auto                     # Defaults to: :auto
set :rvm_ruby_version, '2.1.2@structureresearch'      # Defaults to: 'default'
# set :rvm_custom_path, '~/.myveryownrvm'  # only needed if not detected
set :rvm_roles, [:app, :web]


set :tmp_dir, "/root/tmp"



# set :puma_bind, %w(tcp://0.0.0.0:9292 unix:///tmp/puma.sock)

set :nginx_server_name, 'structureresearch.net'
set :nginx_sites_available_path, '/etc/nginx/conf.d'
set :nginx_sites_enabled_path, '/etc/nginx/conf.d'
set :nginx_config_name, 'structure_research_production.conf'


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      # execute "/etc/init.d/puma restart" # assumes puma jungle tools installed
    end
  end

  task :setup_config do
    on roles(:all) do
      # execute "sudo ln -nfs #{current_path}/config/apache.conf /etc/apache2/sites-enabled/#{fetch(:application)}"
      # execute "sudo /etc/init.d/puma add #{current_path} deployer #{current_path}/config/puma.rb #{current_path}/log/puma.log"
      # execute "mkdir -p #{shared_path}/config"
      # execute "cp #{current_path}/config/database.example.yml #{shared_path}/config/database.yml"
      # puts "Now edit the config files in #{shared_path}."
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
