
Rake::Task["puma:nginx_config"].clear_actions
namespace :puma do
  desc "Setup nginx configuration"
  task :nginx_config do
    on roles(fetch(:puma_nginx, :web)) do |role|
      template_puma("nginx_conf", "/tmp/nginx_#{fetch(:nginx_config_name)}", role)
      sudo :mv, "/tmp/nginx_#{fetch(:nginx_config_name)} #{fetch(:nginx_sites_available_path)}/#{fetch(:nginx_config_name)}"
      # sudo :mv "/tmp/nginx_#{fetch(:nginx_config_name)} #{fetch(:nginx_sites_available_path)}/#{fetch(:nginx_config_name)}"
      # :ln, '-fs', "#{fetch(:nginx_sites_available_path)}/#{fetch(:nginx_config_name)} #{fetch(:nginx_sites_enabled_path)}/#{fetch(:nginx_config_name)}"
      sudo "service nginx restart"
    end
  end
end