<img width="300px" align="right" alt="logo_mmmv" src="https://mmartinezdev.com/images/logo_white.png">

# Ngnix Proxy MultiSite

### Docker

#### Ing. Miguel Manuel Martínez Vázquez

[![Versión](https://img.shields.io/badge/Versión-0.0.1-blue.svg)](https://github.com/djmai/curso-node-restserver/releases/tag/curso-node-restserver-v.0.0.1)
[![donate](https://www.paypalobjects.com/es_ES/i/btn/btn_donate_SM.gif)](https://paypal.me/IngMiguelMartinez?locale.x=es_XC)
[![Whatsapp](https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white)](https://wa.link/7trr5f)
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/W7W86SX6E)

## Introducción

Este proyecto hace uso de los siguientes componentes

- Docker
  - Ngnix Proxy
  - Apps (PHP, Node)

## Enlaces rápidos

- [Notas 🚀](#Notas)
- [Construido con 🛠️](#Construido)
- [Contribuyendo 🖇️](#Contribuyendo)
- [Wiki 📖](#Wiki)
- [Versionado 📌](#Versionado)
- [Autores ✒️](#Autores)
- [Licencia 📄](#Licencia)
- [Expresiones de Gratitud 🎁](#Gratitud)

<a name="Notas" />

## Notas 🚀

```bash
# Clona el repo desde tu terminal:
> git clone https://github.com/djmai/ngnix-proxy-multisite-docker.git

```
### Reconstruir Modules Node
```bash
# Ejecutar el siguiente comando para generar los nuevos contenedores
> docker-compose up -d

```

<a name="Construido" />

## Construido con 🛠️

_Utilizamos las siguientes herramientas para desarrollar este proyecto_
 
 - Docker

Recuerda editar el archivo default.conf en base al numero de apps que quieras servir por sus puertos especificos

```bash
# App por le puerto 8080 con PHP 8
  server {
    listen 80;
    index index.php index.html;
    server_name phpfpm.local;
    error_log  /var/log/nginx/error-php8.log;
    access_log /var/log/nginx/access-php8.log;

    root /var/www/html/api; # ruta en el servidor

    location ~ \.php$ {
      try_files $uri =404;
      fastcgi_split_path_info ^(.+\.php)(/.+)$;
      fastcgi_pass php-fpm:9000; # el nombre de php-fpm debe coincidir con el nombre server_name
      fastcgi_index index.php;
      include fastcgi_params;
      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
      fastcgi_param PATH_INFO $fastcgi_path_info;
    }
  }

```

Editar el docker-compose.yml para agregar los contenedores que quieras manerjar para este stack de aplicaciones

<a name="Contribuyendo" />

## Contribuyendo 🖇️

Por favor lee el [CONTRIBUTING.md](https://github.com/djmai/ngnix-proxy-multisite-docker/CONTRIGUTING.md) para detalles de nuestro código de conducta, y el proceso para enviarnos pull requests.

<a name="Wiki" />

## Wiki 📖

Puedes encontrar mucho más de cómo utilizar este proyecto en nuestra [Wiki](https://github.com/djmai/ngnix-proxy-multisite-docker/wiki)

<a name="Versionado" />

## Versionado 📌

Usamos [SemVer](http://semver.org/) para el versionado. Para todas las versiones disponibles, mira los [tags en este repositorio](https://github.com/djmai/ngnix-proxy-multisite-docker/tags).

<a name="Autores" />

## Autores ✒️

_Menciona a todos aquellos que ayudaron a levantar el proyecto desde sus inicios_

- **Ing. Miguel Martinez** - [djmai](https://github.com/djmai)

También puedes mirar la lista de todos los [contribuyentes](https://github.com/djmai/ngnix-proxy-multisite-docker/CONTRIBUTING.md) quíenes han participado en este proyecto.

<a name="Licencia" />

## Licencia 📄

<a name="Gratitud" />

## Expresiones de Gratitud 🎁

- Comenta a otros sobre este proyecto 📢
- Invita una cerveza 🍺 o un café ☕ a alguien del equipo.
- Da las gracias públicamente 🤓.
- etc.

---

⌨️ con ❤️ por [Ing. Miguel Martinez](https://github.com/djmai) 😊
