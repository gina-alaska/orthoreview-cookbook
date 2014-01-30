#
# Cookbook Name:: ortho_review-cookbook
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

app_name = 'ortho_review'

account = node[app_name]['account']

include_recipe 'user'
include_recipe 'user::data_bag'

# user_account account do
# end

node[app_name]['package_deps'].each do |pkg|
  package pkg do
    action :install
  end
end

# node[app_name]['npm_deps'].each do |pkg|
#   npm_package pkg do
#     action :install
#   end
# end
# include_recipe "gina-webapp::postgresql"
# include_recipe "runit"

include_recipe "ortho_review::ruby"