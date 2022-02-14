# frozen_string_literal: true

only_if('archlinux does not has a repository') do
  os[:name] != 'arch'
end

case platform.family
when 'redhat', 'fedora', 'suse'
  os_name_repo_file = {
    'opensuse' => '/etc/zypp/repos.d/docker-ce.repo'
  }
  os_name_repo_file.default = '/etc/yum.repos.d/docker-ce.repo'

  os_name_repo_url = {
    'amazon' => 'https://download.docker.com/linux/centos/7/$basearch/stable',
    'fedora' => 'https://download.docker.com/linux/fedora/$releasever/$basearch/stable',
    'opensuse' => 'https://download.docker.com/linux/sles/$releasever/$basearch/stable'
  }
  os_name_repo_url.default = "https://download.docker.com/linux/centos/#{platform.release.to_i}/$basearch/stable"
  repo_url = os_name_repo_url[platform.name]
  repo_file = os_name_repo_file[platform.name]

when 'debian'
  repo_keyring = '/usr/share/keyrings/docker-archive-keyring.gpg'
  repo_file = '/etc/apt/sources.list.d/docker.list'
  # rubocop:disable Layout/LineLength
  repo_url = "deb [signed-by=#{repo_keyring} arch=amd64] https://download.docker.com/linux/#{platform.name} #{system.platform[:codename]} stable"
  # rubocop:enable Layout/LineLength
end

control 'Docker repository keyring' do
  title 'should be installed'

  only_if('Requirement for Debian family') do
    os.debian?
  end

  describe file(repo_keyring) do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
  end
end

control 'Docker repository' do
  impact 1
  title 'should be configured'
  describe file(repo_file) do
    its('content') { should include repo_url }
  end
end
