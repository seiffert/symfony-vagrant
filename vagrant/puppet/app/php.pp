class app::php {
    package {["php5", "php5-cli", "php5-dev", "php5-fpm", "php-apc", "php5-mysql"]:
        ensure => present,
        notify => Service["nginx"],
    }

    file {"/etc/php5/fpm/pool.d":
        ensure => directory,
        owner => root,
        group => root,
        require => [Package["php5-fpm"]],
    }

    file {"/etc/php5/fpm/pool.d/$vhost.conf":
        ensure => present,
        owner => root,
        group => root,
        content => template("/vagrant/files/etc/php5/fpm/pool.d/app.conf"),
        require => [File["/etc/php5/fpm/pool.d"]],
        notify => Service["php5-fpm", "nginx"],
    }

    service {"php5-fpm":
        ensure => running,
        hasrestart => true,
        hasstatus => true,
        require => [Package[php5-fpm]],
    }

    exec {"clear-symfony-cache":
        require => Package["php5-cli"],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && /usr/bin/php app/console cache:clear --env=dev && /usr/bin/php app/console cache:clear --env=prod'",
    }
}