app_name = 'ortho_review'

service 'rpcbind' do
  action [:enable, :start]
end

node[app_name]['mounts'].each do |mnt|
  directory mnt['destination'] do
    action :create
    recursive true
    not_if { ::File.exists?(mnt['destination']) }    
  end
  mount mnt['destination'] do
    device mnt['device']
    fstype mnt['fstype']
    options mnt['options']
    action mnt['action']
  end
end