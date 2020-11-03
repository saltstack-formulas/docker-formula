# frozen_string_literal: true

control 'Docker service' do
  title 'should_not be running and enabled'

  describe service('dockerd') do
    it { should_not be_enabled }
    it { should_not be_running }
  end
  describe service('docker') do
    it { should_not be_enabled }
    it { should_not be_running }
  end
end
