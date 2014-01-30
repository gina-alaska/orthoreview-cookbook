app_name = 'ortho_review'

template "#{node[app_name]['shared_path']}/config/sunspot.yml" do
  owner account
  group account
  mode 00644  
  variables(
    :production_host => node[app_name]["sunspot"]["hostname"],
    :production_port => node[app_name]["sunspot"]["port"]
  )
end