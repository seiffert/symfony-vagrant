class app::php {

    case $osfamily {
        'debian' : {$installOptions = {"-t" => "php54"}}
        default  : {$installOptions = {}}
    }

    package {["php5", "php5-cli", "php5-dev", "php5-fpm", "php5-mysql", "php5-apc"]:
        ensure => present,
        notify => Service["nginx"],
        require => Anchor['after_apt'],
        install_options => $installOptions
    }

    file {["/run", "/run/shm"]:
        ensure => directory,
        recurse => true
    }

    file {"/etc/php5/fpm/pool.d":
        ensure => directory,
        owner => root,
        group => root,
        require => Package["php5-fpm"],
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
        require => [Package[php5-fpm], Service['apache2']],
    }

    augeas { "php.ini.cli":
      notify  => [Service['nginx'], Service['php5-fpm']],
      require => Package["php5-cli"],
      context => "/files/etc/php5/cli/php.ini/Date",
      changes => [
        "set date.timezone $time_zone",
      ];
    }
    augeas { "php.ini.fpm":
      notify  => [Service['nginx'], Service['php5-fpm']],
      require => Package['php5-fpm'],
      context => "/files/etc/php5/fpm/php.ini/Date",
      changes => [
        "set date.timezone $time_zone",
      ];
    }

    exec {"clear-symfony-cache":
        require => Package["php5-cli"],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && /usr/bin/php app/console cache:clear --env=dev && /usr/bin/php app/console cache:clear --env=prod'",
    }
}