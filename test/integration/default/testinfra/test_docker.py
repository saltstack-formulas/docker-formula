import testinfra


def test_service_is_running_and_enabled(Service):
    docker = Service('docker')
    assert docker.is_running
    assert docker.is_enabled
