#!/bin/sh
vagrant ssh worker-1 -c "sudo /opt/anypoint/runtimefabric/init.sh"
vagrant ssh worker-2 -c "sudo /opt/anypoint/runtimefabric/init.sh"
