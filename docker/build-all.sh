#!/usr/bin/env bash
echo "Creando imagen ingmartinez/php7.2-fpm:latest"
docker build -t ingmartinez/php7.2-fpm:latest -f Dockerfile .


# comando para publicar en hub.docker.com
# docker login
# docker tag ingmartinez/php7.2-fpm ingmartinez/php7.2-fpm:1.0.1
# docker push ingmartinez/php7.2-fpm:1.0.1