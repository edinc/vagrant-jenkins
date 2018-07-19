# Vagrant Jenkins build [![Build Status](https://travis-ci.org/edinc/vagrant-jenkins.svg?branch=master)](https://travis-ci.org/edinc/vagrant-jenkins)

Run latest Jenkins instance on Ubuntu 16.04 LTS using vagrant.

## Prerequisites
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

## Installation
Build the vagrant box

```
vagrant up
```

To access the Jenkins server

```
http://localhost:8080
```

or, add the following line to the hosts file

```
127.0.0.1   jenkins.local
```

and then run the server with

```
http://jenkins.local:8080
```

## First time accessing Jenkins

Jenkins is set up with one user with
```
username: admin
password: admin
```
usual caveat about changing the password once setup.
