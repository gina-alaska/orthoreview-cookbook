include_recipe 'ortho_review::application'

app_name = 'ortho_review'
account = node['ortho_review']['account']

%w{ application_path shared_path config_path initializers_path }.each do |dir|
  directory node[app_name][dir] do
    owner account
    group account
    mode 00755
    action :create
    recursive true
  end
end
 
include_recipe 'ortho_review::mount_points'

%w{ log tmp system tmp/pids tmp/sockets vendor vendor/assets }.each do |dir|
  directory "#{node[app_name]['shared_path']}/#{dir}" do
    owner account
    group account
    mode 0755
  end
end

link "/home/webdev/#{app_name}" do
  to node[app_name]['deploy_path']
  owner account
  group account
end

# no longer needed using env variables

# template "#{node[app_name]['shared_path']}/config/database.yml" do
#   owner account
#   group account
#   mode 00644
#     
#   variables(node[app_name]["database"])
# end

template "#{node[app_name]['shared_path']}/config/initializers/secret_token.rb" do
  owner account
  group account
  mode 00644  
  variables(node[app_name]["rails"])
end

template "/etc/nginx/sites-available/#{app_name}_site" do
  source 'nginx_site.erb'
  variables({
    install_path: node[app_name]['deploy_path'],
    protected_path: node[app_name]['application_path'],
    name: app_name,
    user: node[app_name]['account'],
  })
end

nginx_site "#{app_name}_site"

unicorn_config "#{node['unicorn_config_path']}/#{app_name}.rb" do
  preload_app true
  listen("#{node[app_name]['shared_path']}/tmp/sockets/unicorn.socket" => {backlog: 1024})
  pid("#{node[app_name]['shared_path']}/tmp/pids/unicorn.pid")
  stderr_path("#{node[app_name]['shared_path']}/log/unicorn.stderr.log")
  stdout_path("#{node[app_name]['shared_path']}/log/unicorn.stdout.log")
  worker_timeout 60
  worker_processes [node['cpu']['total'].to_i * 4, 8].min
  working_directory "#{node[app_name]['deploy_path']}"
  before_fork node[app_name]['before_fork']
  after_fork node[app_name]['after_fork']
end

template "/etc/init.d/unicorn_#{app_name}" do
  source "unicorn_init.erb"
  action :create
  mode 00755
  variables({
    install_path: node[app_name]['deploy_path'],
    unicorn_config_file: "#{node['unicorn_config_path']}/#{app_name}.rb"
  })
end

service "unicorn_#{app_name}" do 
  action :enable
end