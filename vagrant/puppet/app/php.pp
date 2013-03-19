class app::php {

    case $osfamily {
        'debian' : {$installOptions = {"-t" => "php54"}}
        default  : {$installOptions = {}}
    }

    package {["php5", "php5-cli", "php5-dev", "php5-fpm", "php5-mysql", "php5-apc"]:
        ensure => present,
        notify => Service[$webserverService],
        require => Anchor['after_apt'],
        install_options => $installOptions
    }

    exec {"clear-symfony-cache":
        require => Package["php5-cli"],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && /usr/bin/php app/console cache:clear --env=dev && /usr/bin/php app/console cache:clear --env=prod'",
    }

    if 'nginx' == $webserver {
        include app::php::fpm
    }
}
