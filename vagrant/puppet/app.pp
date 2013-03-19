Exec { path => ['/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'], logoutput => true }

class {"apt":
    always_apt_update => true,
    disable_keys => true
}

if $osfamily == 'debian' {
    apt::source {"php54":
        location => "http://packages.dotdeb.org",
        release => 'squeeze-php54',
        repos => "all",
        before => Anchor['after_apt']
    }
}

anchor { 'after_apt': }

$webserverService = $webserver ? {
    apache2 => 'httpd',
    nginx => 'nginx',
    default => 'nginx'
}

host { 'localhost':
    ip => '127.0.0.1',
    host_aliases => ["localhost.localdomain",
                     "localhost4", "localhost4.localdomain4", "$vhost.dev"],
    notify => Service[$webserverService],
}

class { "mysql": }
class { "mysql::server":
    config_hash => {
        "root_password" => $vhost,
        "etc_root_password" => true,
    }
}
Mysql::Db {
    require => Class['mysql::server', 'mysql::config'],
}

include app::php
include app::webserver
include app::tools
include app::database

