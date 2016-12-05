# docker-logfan
Dockerfile for Logfan Docker image based on Alpine

[Logfan](https://github.com/veino/logfan) is a lightweight Logstash replacement written in Go.

## Basic Usage

Create a valid config file e.g. `simple.conf` in a specific folder. 

```bash
docker run -d --name=logfan -v /path/to/config:/config pteich/logfan:latest run /config/simple.conf
```

## Usage like local CLI

You can use this container like a locally available binary.

```bash
docker run -it --rm pteich/logfan --help
```

Be aware that you have to mount your local config folder via `-v` if you need it inside your container.

## Docker-Compose

You can use `docker-compose` to build and start this container. Edit `docker-compose.yml` for your needs.

```bash
docker-compose up -d
```
