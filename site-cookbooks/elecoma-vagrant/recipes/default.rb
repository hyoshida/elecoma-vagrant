#
# Cookbook Name:: elecoma-vagrant
# Recipe:: default
#
# Copyright 2013, hyoshida
#
# All rights reserved - Do Not Redistribute
#

rbenv_script "passenger-install-apache2-module" do
  code "/home/#{node.app['user']}/.rbenv/shims/passenger-install-apache2-module --auto"
  not_if { ::File.exists?(node.passenger['module_path']) }
end 

# rbenv版Rubyを使うようにパス指定
# (node['languages']['ruby']['ruby_bin'] をオーバライドできないのでテンプレート自体を置き換え)
begin
  t = resources(:template => "#{node['apache']['dir']}/mods-available/passenger.conf")
  t.source "passenger.conf.erb"
  t.cookbook 'elecoma-vagrant'
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template 'passenger.conf' to modify"
end

postgresql_connection_info = {
  :host => "127.0.0.1",
  :port => 5432,
  :username => 'postgres',
  :password => "elephant"
}
postgresql_database_user "postgres" do
  connection postgresql_connection_info
  password "elephant"
end


%w(bundle  cached-copy  config  log  pids  system).each do |dir|
  directory "#{node.app['path']}/shared/#{dir}" do
    owner node.app['user']
    group node.app['group']
    mode "0755"
    action :create
    recursive true
  end
end

template "#{node.app['path']}/shared/config/database.yml" do
  source "database.yml.erb"
  owner node.app['user']
  group node.app['group']
  mode "0755"
  #variables(:databases => node.app['databases'].to_hash)
end

deploy node.app['path'] do
  repo node.app['repository']
  revision node.app['revision']
  user node.app['user']
  enable_submodules true
  migrate true
  migration_command "/home/vagrant/.rbenv/shims/rake db:create db:migrate"
  before_migrate do
    rbenv_script "bundle install" do
      user  "vagrant"
      group "vagrant"
      cwd release_path
      code  %{bundle install --path #{node.app['path']}/shared/bundle --without mysql}
      environment node.app['environment']
    end
  end
  environment node.app['environment']
  shallow_clone true
  symlink_before_migrate "config/database.yml" => "config/database.yml"
  purge_before_symlink %w{log tmp/pids public/system config/database.yml}
  create_dirs_before_symlink %w{tmp public config}
  action :deploy # or :rollback
  restart_command "touch tmp/restart.txt"
  scm_provider Chef::Provider::Git # is the default, for svn: Chef::Provider::Subversion
end

web_app node.app['name'] do
  owner node.app['user']
  group node.app['group']

  docroot "#{node.app['path']}/current/public"
  template "elecoma.conf.erb"
  server_name 'localhost'
  rails_env node.app['environment']['RAILS_ENV']
  environment node.app['environment']
end

# TODO: セキュリティ的に問題があるので、ちゃんと設定を行うこと
bash "disable iptables" do
  code "/etc/init.d/iptables stop"
end
