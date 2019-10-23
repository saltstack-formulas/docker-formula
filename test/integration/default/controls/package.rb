# frozen_string_literal: true

control 'Docker package' do
  title 'should be installed'

  package_name =
    case platform[:family]
    when 'debian'
      'docker-ce'
    # Catch remaining `linux` platforms to identify by `name` at the end
    when 'linux'
      case platform[:name]
      when 'arch'
        'docker'
      end
    end

  describe package(package_name) do
    it { should be_installed }
  end
end
