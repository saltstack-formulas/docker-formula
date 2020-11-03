# frozen_string_literal: true

control 'Docker configuration' do
  title 'should match desired lines'

  describe file('/etc/default/docker') do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode')  { should cmp '0640' }
    its('content') { should include 'DOCKER_OPTS="-s btrfs --dns 8.8.8.8"' }
    its('content') { should include 'export http_proxy="http://172.17.42.1:3128"' }
  end
end
