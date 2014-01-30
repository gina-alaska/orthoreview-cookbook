name             'ortho_review'
maintainer       'Will Fisher'
maintainer_email 'will@gina.alaska.edu'
license          'All rights reserved'
description      'Installs/Configures ortho_review application server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

supports "centos", ">= 6.0"

depends "chruby"
depends "npm"
depends "user"
depends "yum", '~> 2.4.4'
depends "application_ruby"
depends "gina", '~> 0.4.6'
depends "gina-postgresql"
depends "nginx"
