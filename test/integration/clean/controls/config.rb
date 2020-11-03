# frozen_string_literal: true

control 'Docker configuration' do
  title 'should_not match desired lines'

  describe file('/etc/default/docker') do
    it { should_not exist }
  end
end
