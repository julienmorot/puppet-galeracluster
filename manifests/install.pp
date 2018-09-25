class galeracluster::install {

    apt::source { "mariadb_deb_repo":
        location => "http://mariadb.mirrors.ovh.net/MariaDB/repo/10.2/ubuntu",
        key      => "199369E5404BD5FC7D2FE43BCBCB082A1BB943DB",
        repos    => "main",
        release  => "${lsbdistcodename}",
    }

#    package { "mariadb-server": ensure => "present" }
    $override_options = {
        'mysqld' => {
            bind-address=>"0.0.0.0",
            binlog_format=>"ROW",
            innodb_autoinc_lock_mode=>2,
            innodb_flush_log_at_trx_commit=>0,
			wsrep_cluster_name => $cluster_name,
        }
    }

    class {'::mysql::server':
        root_password    => $root_password,
        override_options => $override_options,
		package_name     => 'mariadb-server',
		service_name     => 'mysql',
    }


}
