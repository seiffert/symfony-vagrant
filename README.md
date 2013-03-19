# Symfony2 Vagrant Template

This project provides a very slim Symfony2 edition with a vagrant/puppet support. It can be used as template for new
projects.

[![Build Status](https://travis-ci.org/seiffert/symfony-vagrant.png?branch=master)](https://travis-ci.org/seiffert/symfony-vagrant)

## Setup

-   Install vagrant on your system
    see [vagrantup.com](http://vagrantup.com/v1/docs/getting-started/index.html)

-   Get a base box with puppet support
    see [vagrantup.com docs](http://vagrantup.com/v1/docs/getting-started/boxes.html)

-   Install composer on your system
    see [getcomposer.org](http://getcomposer.org/doc/00-intro.md)

-   Create a new project from this template:
    ```bash
        composer create-project seiffert/symfony-vagrant <project-path> 2.1-beta2
    ```

-   In your project directory:
    -   Copy `vagrant/Personalization.dist` to `vagrant/Personalization` and modify `vagrant/Personalization` according to your needs.

        Example:

        ```ruby
            $vhost = "test"
            $ip = "192.168.10.42"

            $use_nfs = true

            $base_box = "ubuntu-server-i386"

            $webserver = "nginx"
        ```
    -   Execute "vagrant up" in the directory vagrant.

-   Add an entry to your `/etc/hosts` file for the selected IP
    If you configured `$vhost = "test"` in the personalization file, the virtual host will be available at [http://test.dev](http://test.dev)

## Infrastructure

After performing the steps listed above, you will have the following environment set up:

- A running virtual machine with your project on it
- Your project directory will be mounted as a shared folder in this virtual machine
- Your project will be accessible via a browser (go to `http://{$vhost}.dev/[app_dev.php]`)
- You can now start customizing the new virtual machine. In most cases, the machine should correspond to the infrastructure your production server(s) provide.

## Installed Bundles

This repository is very similar to the [Symfony2 Standard Edition](https://github.com/symfony/symfony-standard). Besides the addition of vagrant and puppet
configuration files, there is another difference worth mentioning: I removed a couple of bundles which are often a great help but not the very basic feature
set users require for setting up a new project.

Setting up this Edition of Symfony2 will install the following packages:

+ [symfony/symfony](https://packagist.org/packages/symfony/symfony)
+ [doctrine/orm](https://packagist.org/packages/doctrine/orm)
+ [doctrine/doctrine-bundle](https://packagist.org/packages/doctrine/doctrine-bundle)
+ [doctrine/doctrine-fixtures-bundle](https://packagist.org/packages/doctrine/doctrine-fixturesbundle)
+ [symfony/monolog-bundle](https://packagist.org/packages/symfony/monolog-bundle)
+ [sensio/distribution-bundle](https://packagist.org/packages/sensio/distribution-bundle)
+ [sensio/generator-bundle](https://packagist.org/packages/sensio/generator-bundle)
