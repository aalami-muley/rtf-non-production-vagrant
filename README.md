# Vagrant definition for non-production Runtime Fabric
This repository provides with a Vagrant definition for a Runtime Fabric cluster suitable for non production topology.

The cluster is sized given the minimum requirements of one controller and two workers and can be installed with a persistence gateway backed with a PostgreSQL 9 database.

## Configurable settings
The Vagrant definition has a number of settings that can be configured by environment variables. Set these in your host user environment prior to running vagrant commands :

|Variable|Definition|Required|Default value|
|---|---|---|---|
|RTF_ACTIVATION_DATA|The encoded Runtime Fabric activation data. You can access this data by viewing your Runtime Fabric in Runtime Manager.|&check;||
|RTF_MULE_LICENSE|The base64 encoded contents of your organization’s Mule Enterprise license key (`license.lic`).|&check;||
|RTF_PERSISTENCE_GATEWAY|If the postgreSQL machine should be provisionned and initialized to activate the persistence gateway.||1|
|RTF_NETWORK_PREFIX|The private network ip prefix to be used for the vagrant guests.||192.168.56|
|NODE_NAME_PREFIX|The box name prefix to be used for the vagrant guests.||rtf|
|WORKER_CPU|The number of cpus to be assigned to the workers.||2|
|WORKER_MEMORY|The amount of memory in Mo to be assigned to the workers.||15360|
|CONTROLLER_MEMORY|The number of cpus to be assigned to the controller.||2|
|CONTROLLER_CPU|The amount of memory in Mo to be assigned to the controller.||8192|

## Installation steps
First, the cluster's machines should be provisionned, then the cluster can be installed in the controller node then in the workers nodes.
### Provisioning the machines

Vagrant Experimental Feature Flag should be enabled to manage and configure virtual hard disks for etcd and docker.

The activation data and the Mule licence should be provided in the command line. Below an example using the default settings.

```shell
RTF_ACTIVATION_DATA="" RTF_MULE_LICENSE="" VAGRANT_EXPERIMENTAL="1" vagrant up
```

Provisioning the guest will take few minutes

CentOS Linux 8 had reached the End Of Life (EOL) on December 31st, 2021. It means that CentOS 8 will no longer receive development resources from the official CentOS project. After Dec 31st, 2021, if you need to update your CentOS, you need to change the mirrors to vault.centos.org where they will be archived permanently. Alternatively, you may want to upgrade to CentOS Stream.



### Installing the cluster
#### Installing the controller

```shell
./scripts/1-provision-controller.sh
```

#### Installing the workers

```shell
./scripts/2-provision-workers.sh
```

#### Activating the persistence gateway

```shell
./scripts/3-provision-persistence-gateway.sh
```

### Installation checkpoint

```shell
./scripts/4-health-check.sh
```