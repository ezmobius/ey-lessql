#
# Cookbook Name:: tokyo
# Recipe:: default
#

%w[
  dev-db/tokyocabinet
  dev-db/tokyodystopia
  dev-db/tokyotyrant
  dev-ruby/tokyocabinet-ruby
  dev-ruby/tokyotyrant-ruby
].each do |pkg|
  package pkg do
    action :install
  end
end

gem_package "rufus-tokyo" do
  action :install
end

gem_package "tyrantmanager" do
  action :install
end

directory "/data/tyrant" do
  owner node[:owner_name]
  group node[:owner_name]
  mode 0755
  recursive true
end

execute "setup-tyrantmanager-home" do
  command %Q{
    tyrantmanager setup /data/tyrant
  }
  not_if { File.directory?("/data/tyrant/instances") }
end

execute "create-main-tyrant-instance" do
  command %Q{
    tyrantmanager create-instance main --home=/data/tyrant
  }
  not_if { File.directory?("/data/tyrant/instances/main") }
end

execute "start-all-tyrant-instances" do
  command %Q{
    tyrantmanager start all --home=/data/tyrant
  }
end

