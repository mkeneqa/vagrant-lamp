# Vagrant Laravel

Quick and easy development environment for developing Laravel applications using Vagrant.
Uses Vagrant to provision an ubuntu server on virtual box.

## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)

If the vagrant Server is already up and running you can access the the application (in the **_myapp_** directory):  <http://localhost:8088/>

_These IPs will also work: <http://127.0.0.1:8088> or <http://192.168.94.1:8088>_


## Get Started


#### Clone Repo:

```
git clone https://github.com/mkeneqa/vagrant-laravel.git
```

### File Structure

After cloning your folder structure should look like this:

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

#### Server Provisioning with Vagrant

```
vagrant up
```

**Note:** _Vagrant will still be running when the setup is done._


## Usage

After the set up, the server can be started anytime.The vagrant server must be started within the project folder where the __`Vagrantfile`__ is located


### Start Server

Change directories to the folder and start the server. 

Type in the command line:

```
vagrant up
```


### Stop Server

To stop the server type in the terminal:

```
vagrant halt
```

### Access Laravel App
<http://localhost:8088/>


## Existing Applications

If you have an existing application then clone it into  the `myapp` directory.

## Installing New Laravel Application
If starting from scratch follow these steps:

```bash
vagrant ssh

cd /var/www/myapp
composer create-project --prefer-dist laravel/laravel .

# set frontend scaffolding more options: https://laravel.com/docs/7.x/frontend
composer require laravel/ui
php artisan ui bootstrap --auth
npm install
npm run dev
```

## Additional Configs

### Enabling xDebug

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

### PhpStorm IDE Configuration

For the __PhpStorm__ IDE here's a [tutorial to configure xDebug](https://odan.github.io/2019/01/19/install-xdebug-and-configure-phpstorm-for-vagrant.html).