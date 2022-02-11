#!/bin/sh
vagrant ssh controller -c "kubectl create secret generic persistence-gateway-credentials -n rtf --from-literal=persistence-gateway-creds='postgres://pg:pg@192.168.56.20:5432/pg'"
vagrant ssh controller -c "kubectl apply -f /vagrant/assets/pg-custom-resource.yaml"