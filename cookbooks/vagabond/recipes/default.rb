# Necessary steps to run specs
package 'build-essential' do
  action :install
end

gem_package 'bundler' do
  action :install
end

gem_package 'rspec' do
  action :install
end

execute "comment out remote gems" do
  command "sed -i '/group.*remote_test/ s/^/#/' Gemfile"
  cwd "/vagrant"
  action :run
end

execute "bundle install" do
  cwd "/vagrant"
  action :run
end

execute "uncomment remote gems" do
  command "sed -i '/group.*remote_test/ s/^#//' Gemfile"
  cwd "/vagrant"
  action :run
end

# Items for testing specs

template "motd" do
  path '/etc/motd'
  mode 0644
  owner "root"
  group "root"
end

execute "apt-get update" do
  action :run
end

if FileTest.file?("/etc/init.d/apache2")
  service "apache2" do
    action [:stop, :disable]
  end
end
package 'apache2-mpm-worker' do
  action :remove
end

package 'nginx' do
  action :install
end
service "nginx" do
  action [:enable, :start]
end

user "coder" do
  shell "/bin/bash"
end

group "group" do
  members "coder"
  gid 314159
  append true
end
