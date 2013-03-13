class app::database {

    mysql::db { $vhost:
      user     => $vhost,
      password => $vhost,
    }

    exec {"db-drop":
        require => Package["php5-cli"],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && /usr/bin/php app/console doctrine:database:drop --force'",
    }

    exec {"db-setup":
        require => [Exec["db-drop"], Package["php5-cli"]],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && /usr/bin/php app/console doctrine:database:create'",
    }

    exec {"db-migrate":
        require => [Exec["db-setup"], Package["php5-cli"]],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && /usr/bin/php app/console doctrine:migrations:migrate'",
    }

    exec {"db-default-data":
        require => [Exec["db-setup"], Package["php5-cli"]],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost.dev && /usr/bin/php app/console doctrine:fixtures:load'",
        onlyif => "/usr/bin/test -d /srv/www/vhosts/$vhost.dev/src/*/*/DataFixtures",
    }
}