class app::webserver {
    package {"nginx":
        ensure => latest,
        require => Class['apt']
    }

    service {"apache2":
        ensure => stopped,
        require => Package['php5-fpm']
    }

    service {"nginx":
        ensure => running,
        hasrestart => true,
        hasstatus => true,
        require => [Package["nginx"], Service['apache2'], Service['php5-fpm']],
    }

    file {"/etc/nginx/vhosts.d":
        ensure => directory,
        owner => root,
        group => root,
        recurse => true,
        require => Package["nginx"],
    }

    file {"/etc/nginx/fastcgi_params":
        owner => root,
        group => root,
        source => "/vagrant/files/etc/nginx/fastcgi_params",
        require => Package["nginx"],
        notify => Service["nginx"],
    }

    file {"/etc/nginx/nginx.conf":
        owner => root,
        group => root,
        source => "/vagrant/files/etc/nginx/nginx.conf",
        require => Package["nginx"],
        notify => Service["nginx"],
    }

    file {"/etc/nginx/vhosts.d/$vhost.dev.conf":
        owner => root,
        group => root,
        content => template("/vagrant/files/etc/nginx/vhosts.d/app.dev.conf"),
        require => Package["nginx"],
        notify => Service["nginx"],
    }
}
