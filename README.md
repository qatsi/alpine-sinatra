# Runing tiny sinatra application on Docker

This is sample project for running a Sinatra application on Docker on top minimal Alpine Linux image.

## Usage

Create Image

```
docker build --no-cache --force-rm --rm -t alpine-sinatra app/
```

Run it !

```
export SINARTA=$(docker run --rm -p 5678:5678 -d sinatra)
echo ${SINARTA}
```

You can access it from your browser, [http://localhost:5678/](http://localhost:5678/).

Endpoints:
- `/env`
- `/exit`
- `/fail`
- `/sleep[?seconds=3.5]`

Check out logs.

```
docker logs $SINATRA
```

Stop it.

```
docker stop $SINATRA
```

Delete it.

```
docker rm $SINATRA
```

## OS X

Use Vagrant. In `Vagrantfile`, port forwarding setting included!

```
vagrant up
```

and

```
vagrant ssh
```

# Lattice
You can run this in [Lattice](http://lattice.cf)

```
ltc create --run-as-root \
--env RACK_ENV=production \
--env FOO=fubar \
--memory-mb 32 \
--monitor-command 'ps auxww | grep "rackup.*puma" | grep -v grep' \
--monitor-timeout "1s" \
--instances 2 \
alpine-sinatra sashaegorov/alpine-sinatra && \
ltc list
```

## Reference

- [OSX, Vagrant, Docker, and Sinatra | DYLI.SH](http://dyli.sh/2013/08/23/OSX-Vagrant-Docker-Sinatra.html)
- [Sinatra deployment with Docker](http://haanto.com/sinatra-deployment-with-docker/)
