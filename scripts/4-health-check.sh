#!/bin/sh
vagrant ssh controller -c "sudo /opt/anypoint/runtimefabric/rtfctl status"
vagrant ssh controller -c "sudo gravity status"
