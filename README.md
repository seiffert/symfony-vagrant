# Symfony2 Vagrant Template

This project provides a very slim Symfony2 edition with a vagrant/puppet support. It can be used as template for new
projects.

## Setup

-   Install vagrant on your system
    See [http://vagrantup.com](http://vagrantup.com/v1/docs/getting-started/index.html)

-   Get a base box with puppet support.
    See [http://vagrantup.com/v1/docs/getting-started/boxes.html]

-   Install composer on your system
    see [http://getcomposer.org](http://getcomposer.org/doc/00-intro.md)

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
    -   execute "vagrant up" in the directory vagrant.

-   Add an entry in your `/etc/hosts` file for the selected IP
    If you configured `$vhost = "test"` in the personalization file, the system will be made available at [http://test.dev]

    Example:

    ```
        192.168.10.42   test.dev
    ```

## Infrastructure

After performing the steps listed above, you will have the following environment set up: