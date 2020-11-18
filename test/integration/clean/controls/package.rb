# frozen_string_literal: true

PLATFORMS = {
  'suse' => %w[docker],
  'redhat' => %w[docker-ce],
  'debian' => %w[python3-docker docker-ce],
  'arch' => %w[python-docker docker]
}.freeze

control 'Docker packages' do
  title 'should_not be installed'

  packages = PLATFORMS[platform[:family]]
  if packages.is_a? Enumerable
    packages.each do |p|
      describe package(p) do
        it { should_not be_installed }
      end
    end
  end
end
