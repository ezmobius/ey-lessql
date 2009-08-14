#
# Cookbook Name:: mongodb
# Recipe:: default
#

mongoversion = '0.9.5'

directory "/db/mongodb" do
  owner "root"
  group "root"
  mode 0755
  recursive true
end

execute "download-and-install-mongodb" do
  command %Q{
    curl -O http://downloads.mongodb.org/linux/mongodb-linux-i686-#{mongoversion}.tgz &&
    tar xzf mongodb-linux-i686-#{mongoversion}.tgz &&
    cd mongodb-linux-i686-#{mongoversion} &&
    mkdir -p /usr/local/include &&
    mkdir -p /usr/local/lib &&
    mkdir -p /usr/local/bin &&
    cp -R bin/* /usr/local/bin/ &&
    cp -R include/* /usr/local/include/ &&
    cp -R lib/* /usr/local/lib/
  }
  not_if { File.exist?("/usr/local/bin/mongod")}
end

