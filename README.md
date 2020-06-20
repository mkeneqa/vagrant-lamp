# Vagrant Laravel

Wuick and easy dev environment for Laravel development using Vagrant
Uses Vagrant to provision an ubuntu server on virtual box.


## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)

If the vagrant Server is already up and running:
- Access the _myapp_ application:  <http://localhost:8088/>

_These IPs will also work: <http://127.0.0.1> or <http://192.168.94.1>_


## Get Started


##### Clone Repo:

```

git clone https://github.com/mkeneqa/vagrant-laravel.git

```

### File Structure

The files structure within the folder should be as follows:

```

│ README.md
│ Vagrantfile
│
├───myapp
│
├───prepare
│     apache2.conf
│     myapp.conf│     
│     ports.conf
│     setup.sh
│

```

##### Server Provisioning with Vagrant

```

vagrant up

```

**Note:** Vagrant will still be running when the setup is done.  


## Usage

After the set up, the server can be started anytime.The vagrant server must be started within the project folder where the __`Vagrantfile`__ is located


### Start Server

Change directories to the REC folder and start the server. 

Type in the command line:

```

vagrant up

```

or for the lazy, double click the __`vagrant_up.exe`__ file

- Access the Frontend application:  <http://localhost:8080/>
- Access the Backend application: <http://localhost:8090/>


### Stop Server

To stop the server type in the terminal:

```

vagrant halt

```


## Application Configuration

If you have existing applications clone and put into  the `myapp` directory.

A few additional changes are needed to get the application to load properly.

### Front End Configuration

Open and edit the `.env` file in the __frontend__ directory: `/frontend/.env` . Update this key:

```
APIHOST=localhost:8090/
```

### Enabling xDebug

xDebug is already installed on the vagrant server. It just needs to be enabled via the `php.ini`.

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

Restart Apache2 Server: `sudo apachectl restart`

#### PhpStorm IDE Configuration

For the __PhpStorm__ IDE here's a [tutorial to configure xDebug](https://odan.github.io/2019/01/19/install-xdebug-and-configure-phpstorm-for-vagrant.html).