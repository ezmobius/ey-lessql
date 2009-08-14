#
# Cookbook Name:: redis
# Recipe:: default
#

package "dev-db/redis" do
  action :install
end


template "/etc/redis.conf" do
  owner 'root'
  group 'root'
  mode 0644
  source "redis.conf.erb"
  variables({
    :basedir => '/data/redis',
    :logfile => '/data/redis/redis.log',
    :bind_address => '127.0.0.1', # '0.0.0.0' if you want couch available to the outside world
    :port  => '6379',# change if you want to listen on another port
    :loglevel => 'notice',
    :timeout => 3000,
    :sharedobjects => 'no'
  })
end

directory "/data/redis" do
  owner node[:owner_name]
  group node[:owner_name]
  mode 0755
  recursive true
end

gem_package "ezmobius-redis-rb" do
  source "http://gems.github.com"
  action :install
end

execute "ensure-redis-is-running" do
  command %Q{
    /usr/bin/redis-server /etc/redis.conf
  }
  not_if "pgrep redis-server"
end