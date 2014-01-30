site :opscode
group :integration do
  cookbook 'minitest-handler'
end

cookbook "nginx"
cookbook "npm"
cookbook "application_ruby"
cookbook "yum", '~> 2.4.4'
cookbook "gina", '= 0.4.6', chef_api: :config
cookbook "gina-postgresql", chef_api: :config

# cookbook "gina-webapp", path: "/Users/scott/workspace/cookbooks/gina-webapp" #chef_api: :config

cookbook "chruby"
cookbook "user", git: 'http://github.com/fnichol/chef-user'

metadata
