#!/bin/sh
kubectl create secret generic persistence-gateway-credentials -n rtf --from-literal=persistence-gateway-creds='postgres://pg:pg@192.168.56.20:5432/pg'
kubectl apply -f pg-custom-resource.yaml