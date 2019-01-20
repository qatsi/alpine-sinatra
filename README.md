# Sinatra in Docker

[Alpine Sinatra](https://hub.docker.com/r/sashaegorov/alpine-sinatra/) is tiny Sinatra application which runs in Docker on top minimalistic Alpine Linux image.

### Create Image

Run and login into Vagrant box:
```
vagrant up && vagrant ssh  
```
After successful login:
```  
cd /vagrant/
docker build --no-cache \
 --force-rm --rm -t \
 alpine-sinatra .
```

Run and check
```
docker run -d -p 5678:5678 alpine-sinatra
docker ps
```

… or run locally (another port used to avoid conflicts)

```
rerun 'bundle exec rackup -o 0.0.0.0 -p 5679'
```

Access it from your browser via [http://localhost:5678](http://localhost:5678).

Endpoints:
- `/env[?json=yes]` look Ma! Environment.
- `/disk` quick and dirty output of `df -h`
- `/memory` output of `free -m`
- `/exit` send TERM signal to app i.e. exit correctly
- `/fail` send KILL to app i.e. exit *incorrectly*
- `/sleep[?seconds=3.5]` wait like a pro...
- `/form` simple form with POST method

Check out logs.

```
docker logs $SINATRA
docker logs -f $SINATRA
```

Stop it (takes 10 seconds by default)

```
docker stop $SINATRA
```

Delete it.

```
docker rm $SINATRA
```

Clean up after it

```
docker images | grep '<none>' | awk '{print $3}' | xargs docker rmi -f
```

Clean up all

```
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
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

## Playing with `curl`

Here `http://localhost:5678/form` is default development URL if application was started with `rackup app/sinatra/config.ru`.

```
curl --form 'message=Hello world!✔︎' --form 'log=yes' http://localhost:5678/form
Hello world!✔︎⏎
```

## Commands

```
docker image inspect alpine-sinatra:latest --format='{{.Size}}'
```

### If thinks went wrong

```
docker run -ti -p 5678:5678 alpine-sinatra /bin/sh
```
