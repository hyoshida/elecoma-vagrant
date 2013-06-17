#
# Cookbook Name:: elecoma-vagrant
# Recipe:: default
#
# Copyright 2013, hyoshida
#
# All rights reserved - Do Not Redistribute
#

ruby_build_ruby "1.9.3-p429"

=begin
application "elecoma" do
  path "/usr/local/www/elecoma"

  rails do 
    database do
      database "ec"
      username "ec"
      password "elephant"
    end
  end

  passenger_apache2
end
=end
