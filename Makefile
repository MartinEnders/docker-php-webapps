run: build push

build:
	docker build -t martinenders/php-webapps:latest .
push:
	docker push martinenders/php-webapps:latest
