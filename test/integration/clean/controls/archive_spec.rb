# frozen_string_literal: true

title 'docker-compose archives profile'

control 'docker-compose archive' do
  impact 1.0
  title 'should_not be installed'

  describe file('/usr/local/docker-compose-latest/bin') do
    it { should_not exist }
  end
  describe file('/usr/local/bin/docker-compose') do
    it { should_not exist }
  end
end
