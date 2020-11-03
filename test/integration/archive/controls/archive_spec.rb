# frozen_string_literal: true

title 'docker archives profile'

control 'docker archive' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/docker-19.03.9/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/docker-19.03.9/bin/docker') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/docker-19.03.9/bin/runc') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/docker-19.03.9/bin/docker-proxy') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/docker-19.03.9/bin/containerd') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/docker-19.03.9/bin/ctr') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/docker-19.03.9/bin/dockerd') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/docker-19.03.9/bin/containerd-shim') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/docker') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/runc') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/docker-proxy') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/containerd') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/ctr') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/dockerd') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/containerd-shim') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/docker-compose-latest/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/docker-compose-latest/bin/docker-compose') do
    it { should exist }
    it { should be_file }
    it { should_not be_directory }
    its('mode') { should cmp '0755' }
    its('type') { should eq :file }
  end
  describe file('/usr/local/bin/docker-compose') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
end
