# galeracluster

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)

## Description

This module help you to build a simple MariaDB/Galera cluster.
I've only tested this module againts Ubuntu 18.04.

## Setup

You must not have currently installed MariaDB or MySQL on the target system.

## Usage

You have to include the class in your configuration and define two things :
- The cluster name
- The nodes participating to the cluster

Example :
```
node 'db1' {
        class { 'galeracluster':
                galeracluster_name  => "MyAmazingGaleraCluster",
                galeracluster_nodes => [ 'db1.int.morot.fr', 'db2.int.morot.fr', 'db3.int.morot.fr' ],
        }
}
```

## Limitations

So many!
