class galeracluster::install {

    apt::source { "mariadb_deb_repo":
        location => "http://mariadb.mirrors.ovh.net/MariaDB/repo/10.2/ubuntu",
        key      => "0xF1656F24C74CD1D8",
        repos    => "main",
        release  => "${lsbdistcodename}",
    }

    package { "mariadb-server": ensure => "present" }

}
