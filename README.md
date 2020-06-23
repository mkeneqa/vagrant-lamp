# Vagrant Lamp Stack

Quick and easy development environment for developing LAMP apps - eg. Laravel applications - using Vagrant.

This setup uses Vagrant to provision an ubuntu LAMP server on virtual box.

## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)

If the vagrant Server is already up and running you can access the the application (in the **_myapp_** directory):  <http://localhost:8088/>

_These IPs will also work: <http://127.0.0.1:8088> or <http://192.168.94.1:8088>_

## Main Sections:
- [Getting Start](#get-started)
- [Adding Existing Applications](#existing-applications)
- [MySQL Config](#mysql-use)
- [Setting Hostnames](#setting-vagrant-with-hostname)
- [Enabling xDebug](#enabling-xdebug)
- [Installing Laravel from Scratch](#installing-laravel-from-scratch)



# Get Started


### Download Repo:

```
git clone https://github.com/mkeneqa/vagrant-lamp.git
```

or [Download it here](https://github.com/mkeneqa/vagrant-lamp/archive/default.zip)

### File Structure

After downloading/cloning, your folder structure should look like this:

```
│ README.md
│ Vagrantfile
│
├───myapp
│
├───prepare
│     apache2.conf
│     myapp.conf
│     ports.conf
│     setup.sh
│
```

### Server Provisioning with Vagrant

This will go through the process of provisioning your VM. Additionally, you may want to set up Private networking to use hostname. [See Notes on Setting Vagrant with Hostname](#setting-vagrant-with-hostname)

```
vagrant up
```

**Note:** _Vagrant will still be running when the setup is done._


## Usage

The vagrant server must be started within the project folder where the __`Vagrantfile`__ is located.


### Start Server

Type in the command line:

```
vagrant up
```


### Stop Server

To stop the server type in the terminal:

```
vagrant halt
```

### Delete Vagrant Server

```
vagrant destroy --f
```

**NOTE:** _This won't remove files and folders within the `myapp` directory_


## Access App
<http://localhost:8088/> _or the specified domain if hostname is configured_



# Additional Options

Extra options that may help with setting up your application.


## Existing Applications

If you alread have an existing application just `git clone` it into  the `myapp` directory 

Make sure to put the (**.**) _period_ at the end to avoid creating a nested folder.

example: `git clone https://github.com/user/myapp.git .`

## MySQL Access

#### !! WARNING: This should only be used in development and NOT PRODUCTION!!

Command line : `mysql -uroot -proot`

**host:** `localhost` or `127.0.0.1` (or whatever ip you have specified if using private network)

**user:** `root`

**pswd:** `root`

**port:** `33306`

**pre-created database:** `myapp_db`


## Setting Vagrant with Hostname:

This configuration allows the use of a FQDN and not ip addresses eg. mydomain.local


### 1. Set Network Options in Vagrant File

Uncomment these lines in the `Vagrantfile` and save. 
You can use whatever domain you want but don't use the `.dev` TLD.

```
# config.vm.network "private_network", ip: "192.168.10.10"
# config.vm.hostname = '<yourdomain>.local'
```

### 2. Add Domain Entry to Hosts File
In Windows open the command line application as Administrator. 

Type this in the command line: `notepad.exe C:\Windows\System32\drivers\etc\hosts`

Add domain entry to **hosts** file in notepad and save:

eg:

```
192.168.10.10       	<yourdomain>.local
```

### 3. Restart Vagrant

```
vagrant reload
```


**NOTE**: _This has been tested on Windows host but should work on other host OS. You'll need to change the OS host file accordingly_

**Sources:**

[Vagrant Private Network](https://www.vagrantup.com/docs/networking/private_network#static-ip)

[Vagrant With Hostname](https://unix.stackexchange.com/questions/493484/how-do-i-configure-a-vagrant-virtual-machine-with-a-host-name)



## Enabling xDebug

**NOTE**: _This should already be enabled during the Vagrant provisioning step_

xDebug is already installed on the vagrant server. It may need to be enabled via the `php.ini`.

First log in to the vagrant server using : `vagrant ssh`

Then run the following commands (or manually add them to the `php.ini` file):

```
echo 'xdebug.remote_port=9000' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_enable=true' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_connect_back=true' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_autostart=on' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_host=' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.max_nesting_level=1000' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.idekey=PHPSTORM' >> /etc/php/7.4/apache2/php.ini
```
Restart apache server: `sudo apachectl restart`

### Configure XDebug with PhpStorm IDE

For the __PhpStorm__ IDE here's a [tutorial to configure xDebug](https://odan.github.io/2019/01/19/install-xdebug-and-configure-phpstorm-for-vagrant.html).


## Installing Laravel from Scratch


```bash
vagrant ssh

cd /var/www/myapp

composer create-project --prefer-dist laravel/laravel .
composer require laravel/ui
php artisan ui bootstrap --auth
npm install
npm run dev
```

Read more on [Laravel frontend scaffolding options](https://laravel.com/docs/7.x/frontend)


**NOTE:** _Steps above should work for other LAMP apps like Symfony4 and WordPress_