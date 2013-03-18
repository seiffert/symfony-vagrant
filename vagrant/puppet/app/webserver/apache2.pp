class app::webserver::apache2 {
    class { "apache": }
    class { "apache::mod::php": }

    service { "nginx":
        ensure => stopped,
    }

    file {"/etc/apache2/sites-enabled/000-default":
        ensure => absent,
        notify => Service["httpd"],
    }

    file {"/etc/apache2/sites-enabled/$vhost":
        ensure => present,
        content => template("/vagrant/files/etc/apache2/sites-available/app.dev"),
        require => Package["apache2"],
        notify => Service["httpd"],
    }

    a2mod { 'rewrite': ensure => present, }
}
