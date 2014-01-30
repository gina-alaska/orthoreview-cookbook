#  Assuming webapp might use this variable at some point.
default['unicorn_config_path'] = '/etc/unicorn'

# Orthoreview Website node attributes

default['ortho_review']['application_path'] = "/www/ortho_review"
default['ortho_review']['shared_path'] = "#{default['ortho_review']['application_path']}/shared"
default['ortho_review']['previews_path'] = "#{default['ortho_review']['shared_path']}/previews"
default['ortho_review']['config_path'] = "#{default['ortho_review']['shared_path']}/config"
default['ortho_review']['initializers_path'] = "#{default['ortho_review']['config_path']}/initializers"
default['ortho_review']['deploy_path'] = "#{default['ortho_review']['application_path']}/current"

# default['ortho_review']['database']['adapter']  = "postgresql"
# default['ortho_review']['database']['hostname'] = ""
# default['ortho_review']['database']['database'] = "browse_prod"
# default['ortho_review']['database']['username'] = "browse_web"
# default['ortho_review']['database']['password'] = ""
# default['ortho_review']['database']['search_path'] = "public"

# default['ortho_review']['sunspot']['hostname'] = "localhost"
# default['ortho_review']['sunspot']['port'] = "8983"

default['ortho_review']['rails']['secret'] = '87cf47e2b8a1739b63efc4ff2cae7a749af099803f6d93f832004f7b7b5c36599829e84448ed2a5a2a6f15413f664f960c6ee8b999b30e9cc1b4ba37a96a1d90'
default['ortho_review']['rails']['application_class_name'] = 'Photos'

# Global BROWSE node attributes

default['ortho_review']['account'] = "webdev"

default['ortho_review']['mounts'] = [{
  'device' => 'zim.gina.alaska.edu:/san/sdmi_source',
  'destination' => default['ortho_review']['previews_path'],
  'fstype' => 'nfs',
  'options' => 'ro',
  'action' => [:mount, :enable]
}]

default['ortho_review']['before_fork'] = '
defined?(ActiveRecord::Base) and
   ActiveRecord::Base.connection.disconnect!
   
   old_pid = "#{server.config[:pid]}.oldbin"
   if old_pid != server.pid
     begin
       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
       Process.kill(sig, File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
     end
   end
      
sleep 1
'

default['ortho_review']['after_fork'] = "
defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
"

default['ortho_review']['package_deps'] = %w{libicu-devel curl-devel libxml2-devel libxslt-devel nfs-utils ImageMagick-devel nodejs npm}

default['users'] ||= []
%w{ webdev }.each do |user|
  default['users'] << user unless default['users'].include?(user)
end
