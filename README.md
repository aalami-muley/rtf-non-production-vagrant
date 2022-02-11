# Vagrant definition for non-production Runtime Fabric
This repository provides with a Vagrant definition for a [Runtime Fabric](https://docs.mulesoft.com/runtime-fabric/1.11/) cluster suitable for [non production](https://docs.mulesoft.com/runtime-fabric/1.11/install-prereqs#development-configuration-requirements) topology.

The cluster is sized given the minimum requirements of one controller and two workers and can be installed with a [persistence gateway](https://docs.mulesoft.com/runtime-fabric/1.11/persistence-gateway) backed with a PostgreSQL 9 database.

## Configurable settings
The Vagrant definition has a number of settings that can be configured by environment variables. Set these in your host user environment prior to running vagrant commands :

|Variable|Definition|Required|Default value|
|---|---|---|---|
|RTF_ACTIVATION_DATA|The encoded Runtime Fabric activation data. You can access this data by viewing your Runtime Fabric in Runtime Manager.|&check;||
|RTF_MULE_LICENSE|The base64 encoded contents of your organization’s Mule Enterprise license key (`license.lic`).|&check;||
|RTF_PERSISTENCE_GATEWAY|If the PostgreSQL machine should be provisioned and initialised to activate the persistence gateway.||1|
|RTF_NETWORK_PREFIX|The private network ip prefix to be used for the vagrant guests.||192.168.56|
|NODE_NAME_PREFIX|The box name prefix to be used for the vagrant guests.||rtf|
|WORKER_CPU|The number of cpus to be assigned to the workers.||2|
|WORKER_MEMORY|The amount of memory in Mo to be assigned to the workers.||15360|
|CONTROLLER_MEMORY|The number of cpus to be assigned to the controller.||2|
|CONTROLLER_CPU|The amount of memory in Mo to be assigned to the controller.||8192|

## Installation steps
First, the cluster's machines should be provisioned, then the cluster can be installed in the controller node then in the workers nodes.

### Provisioning the machines

Vagrant Experimental Feature Flag is enabled explicitly configure virtual hard disks for Etcd and Docker.

The [activation data](https://docs.mulesoft.com/runtime-fabric/latest/install-create-rtf-arm) and the Mule licence should be provided in the command line. Below an example using the default settings.

```shell
RTF_ACTIVATION_DATA="" RTF_MULE_LICENSE="" vagrant up
```

### Installing the cluster

#### Installing the controller

The script below will perform the installation of the controller after the pre-flight are checked:

```shell
./scripts/1-provision-controller.sh
```

#### Installing the workers

The script below will perform the installation of the workers sequentially:

```shell
./scripts/2-provision-workers.sh
```

#### Installing the persistence gateway

The Persistence Gateway will be configured with a Kubernetes custom resource connected to the database already provisioned.

```shell
./scripts/3-provision-persistence-gateway.sh
```

### Installation checkpoint

Use the command below to check that the cluster is healthy :

```shell
./scripts/4-health-check.sh
```

The [Ops Center](https://docs.mulesoft.com/runtime-fabric/latest/using-opscenter) should be accessible from the url https://192.168.56:32009/web with `admin@runtime-fabric` as the defualt username.

The password can be retrieved using the script :

```shell
./scripts/5-check-ops-center-credentials.sh
```

