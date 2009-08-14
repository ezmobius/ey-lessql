#
# Cookbook Name:: cassandra
# Recipe:: default
#

package "sun-java6-jre" do
  action :install
end

directory "/mnt/cassandra" do
  owner node[:owner_name]
  group node[:owner_name]
  mode 0755
  recursive true
end

remote_file "/tmp/cassandra.tgz" do
  source "http://apache.mirror.facebook.net/incubator/cassandra/0.3.0/apache-cassandra-incubating-0.3.0-bin.tar.gz"
  mode "0644"
  checksum "bfbb9cd29866ac31217f72c57e277a67" # A SHA256 (or portion thereof) of the file.
end

template "/etc/cassandra/storage-conf.xml" do
  owner 'root'
  group 'root'
  mode 0644
  source "storage-conf.xml.erb"
  variables({
    :basedir => '/mnt/cassandra',
  })
end