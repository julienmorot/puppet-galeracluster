# Class: galeracluster
# ===========================
#
# Full description of class galeracluster here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'galeracluster':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Julien Morot <jmorot@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2018 Julien Morot
#
class galeracluster (
	$root_password = 'G@leraP4ssw0rd',
	$galeracluster_name   = '',
    $galeracluster_nodes = '',
	$galeracluster_port  = "3306",
	) {

    $bootstrap_node = $galeracluster_nodes[0]
    $bootstrap_cmd = "/usr/bin/galera_new_cluster"
	$bootstrap_check_cmd = "/usr/local/bin/wsrep_port_tester.sh"

	include galeracluster::install

    file { '/etc/mysql/conf.d/wsrep.cnf':
	    ensure  => file,
    	owner   => 'root',
	    group   => 'root',
	    mode    => '0644',
	    content => template("${module_name}/wsrep.cnf.erb"),
	    notify => Service['mysql']
    }

    file { '/usr/local/bin/wsrep_port_tester.sh':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => template("${module_name}/wsrep_port_tester.sh.erb"),
    }

	if $fqdn == $bootstrap_node {
        Exec { 'bootstrap_galeracluster':
            command => $bootstrap_cmd,
            unless => $bootstrap_check_cmd,
        #    require => Class['mysql::server'],
            before => Service['mysql']
        }
	}


}

