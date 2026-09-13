# Zabbix Proxy: Ubuntu y SQLite

Imagen personalizada a partir de la imagen oficial Ubuntu de Zabbix Proxy con
SQLite. Mantiene el entrypoint y la configuración por variables de entorno de
Zabbix y añade herramientas básicas de diagnóstico.

| Herramienta | Uso |
|---|---|
| `curl` | Comprobar servicios HTTP/HTTPS |
| `dig`, `nslookup` | Consultar DNS |
| `ip`, `ss` | Inspeccionar interfaces, rutas y sockets |
| `ping` | Comprobar conectividad ICMP |
| `nc` | Comprobar puertos TCP |
| `openssl` | Inspeccionar TLS y certificados |

Se incluyen certificados CA para las conexiones HTTPS. Las herramientas se
instalan durante la construcción con root; el contenedor se ejecuta como `zabbix`.
La disponibilidad de ICMP depende también de las capacidades del entorno de ejecución.

## Construcción en Linux

Requiere Docker instalado y accesible desde tu usuario. Ejecuta los comandos desde
el directorio del repositorio.

Se conserva Zabbix 7.0.26 como punto de partida de la propuesta anterior.

```sh
docker build -t zabbix-proxy-image:7.0.26-ubuntu .
```

Para utilizar otra versión oficial publicada, cambia el argumento de construcción
y el tag de tu imagen:

```sh
docker build \
  --build-arg ZABBIX_VERSION=7.0.26 \
  -t zabbix-proxy-image:7.0.26-ubuntu .
```

## Comprobación rápida

```sh
docker run --rm --entrypoint sh \
  zabbix-proxy-image:7.0.26-ubuntu \
  -c 'id; zabbix_proxy --version; for tool in curl dig nslookup ip ss ping nc openssl; do command -v "$tool" || exit 1; done'
```

Esta comprobación no arranca un proxy conectado al servidor ni crea una base de datos.
La configuración por cliente y la persistencia corresponden al despliegue.

## Base oficial

[Zabbix Proxy SQLite en Docker Hub](https://hub.docker.com/r/zabbix/zabbix-proxy-sqlite3).

La versión de Zabbix está fijada mediante tag. El tag upstream y los paquetes de
Ubuntu pueden actualizarse: esta primera propuesta aún no fija digests ni versiones
individuales de paquetes.
