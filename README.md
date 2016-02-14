# PHP7 Development Environment with XDebug
LEMP Vagrant Box using Puppet. [ NGINX + MYSQL + PHP7 ] + MongoDB

This is a simple vagrant ubuntu/trusty64 box that includes all the essential puppet modules to run a LEMP development environment out of the box. XDebug 2.4 is also now included for debugging needs.

## what is vagrant?

Vagrant is a tool that dynamically builds configurable, lightweight, and portable virtual machines. Much more information is available on [their website](http://www.vagrantup.com).

## how do I install vagrant?

Vagrant is free and can be [downloaded here](http://www.vagrantup.com/).

## how do I run my app?

Simply clone this git repository and run vagrant up. Note: Move your application to 'lemphp7/app' directory.

To run the box.

```
git clone https://github.com/weop/lemphp7
vagrant up
```

The web server runs on the private network ip 192.168.11.22 and is accessible on http://192.168.11.22/ or on your localhost
```
http://localhost:8888/
```

To manage mysql, connect via SSH tunnel.
```
mysql host: 127.0.0.1
mysql user: root
mysql pass: root

ssh host: 192.168.11.22
ssh user: vagrant
ssh pass: vagrant
```

## notes

Several configurations used here, makes it unfit to deploy for a production server. If you'd like to use this for a production server, please configure the relevant configuration files.
