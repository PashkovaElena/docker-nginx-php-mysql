# docker-nginx-php-mysql
Docker running Nginx, PHP-FPM, Composer, MySQL and PHPMyAdmin.
=======
Docker running Nginx, PHP-FPM, Composer, MySQL and PHPMyAdmin.

## Overview

1. [Install prerequisites](#install-prerequisites)

    Before installing project make sure the following prerequisites have been met.

2. [Clone the project](#clone-the-project)

    We’ll download the code from its repository on GitHub.


3. [Configure Xdebug](#configure-xdebug) [Optional]

    We'll configure Xdebug for IDE (PHPStorm or Netbeans).

4. [Run the application](#run-the-application)

    By this point we’ll have all the project pieces in place.

5. [Use Makefile](#use-makefile) [Optional]

    When developing, you can use `Makefile` for doing recurrent operations.

6. [Use Docker Commands](#use-docker-commands)

    When running, you can use docker commands for doing recurrent operations.

--------------

## Install prerequisites

The project has been created for Unix `(Linux/MacOS)`.

* [Git](https://git-scm.com/downloads)
* [Docker](https://docs.docker.com/engine/installation/)
* [Docker Compose](https://docs.docker.com/compose/install/)

--------------

### Images to use

* [Nginx](https://hub.docker.com/_/nginx/)
* [MySQL](https://hub.docker.com/_/mysql/)
* [Composer](https://hub.docker.com/_/composer/)
* [PHPMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)

This project use the following ports :

| Server     | Port |
|------------|------|
| MySQL      | 8989 |
| PHPMyAdmin | 8080 |
| Nginx      | 8000 |

--------------

## Clone the project

```sh
git clone https://github.com/PashkovaElena/docker-nginx-php-mysql.git
```

Go to the project directory : 

```sh
cd docker-nginx-php-mysql
```

--------------

## Run the application

1. Start the application :

    ```sh
    make docker-start
    ```

    **Please wait this might take a several minutes...**

    ```sh
    sudo docker-compose logs -f # Follow log output
    ```

2. Open your favorite browser :

    * [http://localhost:8000](http://localhost:8000/)
    * [http://localhost:8080](http://localhost:8080/) PHPMyAdmin (username: dev, password: dev)

3. Stop and clear services

    ```sh
    make docker-stop
    ```

---

## Use Makefile

When developing, you can use [Makefile](https://en.wikipedia.org/wiki/Make_(software)) for doing the following operations :

| Name          | Description                                |
|---------------|--------------------------------------------|
| clean         | Clean directories for reset                |
| composer-up   | Update PHP dependencies with composer      |
| docker-start  | Create and start containers                |
| docker-stop   | Stop and clear all services                |
| logs          | Follow log output                          |
| mysql-dump    | Create backup of whole database            |
| mysql-restore | Restore backup from whole database         |
| test          | Test application with phpunit              |

### Examples

#### MySQL shell access

```sh
docker exec -it mysql bash
```

and

```sh
mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD"
```
