# frozen_string_literal: true

title 'docker-compose archives profile'

control 'docker-compose archive' do
  impact 1.0
  title 'should be installed'

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
