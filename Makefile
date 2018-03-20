# Makefile for Docker Nginx PHP Composer MySQL

include .env

# MySQL
MYSQL_DUMPS_DIR=data/db/dumps

help:
	@echo "usage: make COMMAND"
	@echo "Commands:"
	@echo "  clean               Clean directories for reset"
	@echo "  composer-up         Update PHP dependencies with composer"
	@echo "  docker-start        Create and start containers"
	@echo "  docker-stop         Stop and clear all services"
	@echo "  logs                Follow log output"
	@echo "  mysql-dump          Create backup of whole database"
	@echo "  mysql-restore       Restore backup from whole database"
	@echo "  test                Test application"
	@echo ""
	@echo "Allowed operations outside docker:"
	@echo ""
	@echo "Docker:"
	@echo "   docker-php              Login into docker-php machine"
	@echo "   docker-clean            Clean cache on docker-php machine"
	@echo ""
	@echo "Allowed operations inside docker:"
	@echo ""
	@echo "  Testing:"
	@echo "   phpunit                 Run PHPUnit tests & generate coverage report"
	@echo "   behat                   Run Behat tests"
	@echo "   phpcs                   PHP Code Sniffer"
	@echo "   tests                   All tests"
	@echo ""
	@echo "Utilities:"
	@echo "   clean                   Clean all cache, logs, sessions"
	@echo "   clean-coverage          Clean coverage report"
	@echo ""

clean:
	@rm -Rf data/db/mysql/*
	@rm -Rf $(MYSQL_DUMPS_DIR)/*
	@rm -Rf app/vendor
	@rm -Rf app/composer.lock
	@rm -Rf app/composer.json
	@rm -Rf app/doc
	@rm -Rf app/report
	
composer-up:
	@docker run --rm -v $(shell pwd)/app:/app composer update

init:
	@$(shell cp -n $(shell pwd)/app/composer.json.dist $(shell pwd)/app/composer.json 2> /dev/null)

docker-start: init
	@docker-compose up -d
	@make composer-up
	@make docker-php
	@make clean
	@exit
	
docker-php:
	@echo "\nWelcome to PHP machine\n"
	@docker exec -i -t my_test_project_php bash
	@exit

docker-stop:
	@docker-compose down -v
	@make clean

docker-clean:
	@docker-compose exec -T php php composer.phar docker:cache:clear

logs:
	@docker-compose logs -f

mysql-dump:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	@docker exec $(shell docker-compose ps -q mysqldb) mysqldump --all-databases -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" > $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null
	@make resetOwner

mysql-restore:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null

