# frozen_string_literal: true

PLATFORMS = {
  'suse' => %w[python3-pip tar gzip docker],
  'redhat' => %w[selinux-policy docker-ce],
  'debian' => %w[python3-docker gnupg-agent software-properties-common docker-ce],
  'arch' => %w[python-docker python-pip docker]
}.freeze

control 'Docker packages' do
  title 'should be installed'

  packages = PLATFORMS[platform[:family]]
  if packages.is_a? Enumerable
    packages.each do |p|
      describe package(p) do
        it { should be_installed }
      end
    end
  end
end
