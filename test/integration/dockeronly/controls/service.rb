# frozen_string_literal: true

control 'Docker service' do
  title 'should be running and enabled'

  describe service('docker') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running } unless %w[fedora suse].include? platform[:family]
  end
end
