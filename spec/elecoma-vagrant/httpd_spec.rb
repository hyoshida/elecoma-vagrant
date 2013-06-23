# -*- encoding: utf-8 -*-
require 'spec_helper'

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/httpd/conf/httpd.conf') do
  it { should be_file }
end

describe command('curl localhost') do
  it { should return_stdout /#{ERB::Util.html_escape("K&B style")}/ }
end
