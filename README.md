# Symfony2 Vagrant Template

This project provides a very slim Symfony2 edition with a vagrant/puppet support. It can be used as template for new
projects.

## Setup

-   Install vagrant on your system  
    see [vagrantup.com](http://vagrantup.com/v1/docs/getting-started/index.html)

-   Get a base box with puppet support  
    see [vagrantup.com docs](http://vagrantup.com/v1/docs/getting-started/boxes.html)

-   Install composer on your system  
    see [getcomposer.org](http://getcomposer.org/doc/00-intro.md)

-   Create a new project from this template:
    ```bash
        composer create-project seiffert/symfony-vagrant <project-path>
    ```

-   In your project directory:
    -   Copy `vagrant/Personalization.dist` to `vagrant/Personalization` and modify `vagrant/Personalization` according to your needs.

        Example:

        ```ruby
            $vhost = "test"
            $ip = "192.168.10.42"

            $use_nfs = true

            $base_box = "ubuntu-server-i386"
        ```
    -   Execute "vagrant up" in the directory vagrant.

-   Add an entry in your `/etc/hosts` file for the selected IP  
    If you configured `$vhost = "test"` in the personalization file, the virtual host will be available at [http://test.dev](http://test.dev)

    Example:

    ```
        192.168.10.42   test.dev
    ```

## Infrastructure

After performing the steps listed above, you will have the following environment set up: