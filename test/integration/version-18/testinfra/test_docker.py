import testinfra

def test_package_is_installed(Package):
    docker = Package('docker-engine')
    assert docker.is_installed
    assert docker.version.startswith('18.')

def test_service_is_running_and_enabled(Service):
    docker = Service('docker')
    assert docker.is_running
    assert docker.is_enabled
