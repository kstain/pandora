# Pandora Dev Environment
This is a portable web app environment (nginx+uwsgi+flask) built with [docker](https://www.docker.com).

## Prerequisites
* Download & install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Download & install [boot2docker](http://boot2docker.io/)

## Setup Instruction
For Linux/Mac users, there're some simple script written by me. For windows users, however, you may imitate the way the shell scripts do, where the syntax could be a little bit different.

___You don't have to switch to Linux obligatorily. Just stay in the platform where you are comfortable with, where you're equipped with your familiar IDE or some other tools. That's also one of the benefits of using `docker`.___ 

### Build Image
Look into `build.sh`. You may modify `username` and `image` as you like. Then run it:

```
./build
```

### Setup Ports
Open VirtualBox. Select the vm `boot2docker-vm` (remember to install boot2docker as is instructed at very beginning) --> settings.

![vbox-settings](image/vbox-settings.png =190x)

Network --> Port Forwarding

![settings-network](image/settings-network.png =260x)

Add these two ports. You may change change host port if there's any conflict.

![ports](image/ports.png =600x)

### Run Server
I wrote two convenient scripts: `serve.sh` and `explore.sh` to run the image.

* `serve.sh` will run a web server container, which maps the ports out so that you can test the newly written python code. Reminder: `Ctrl-C` and re-run `serve.sh` if you change any python code.
* `explore.sh` will take you into the container. Note this container is different than the container above. Web serviced is __NOT__ started in this container. You may do any experiment in it.

___Before running the script___, please clone `sphinx` to local, and modify `sphinx_root` in `serve.sh` and `explore.sh`, and __They must be in ABSOLUTE path__.

### Check Mounting
`sphinx` is mounted to container when running the above scripts. Yet it could fail because boot2docker doesn't support shared folder very well. Run `explore.sh` and check if `sphinx` is mounted as `/opt/sites/sphinx`.

If not, please refer to [this](https://medium.com/boot2docker-lightweight-linux-for-docker/boot2docker-together-with-virtualbox-guest-additions-da1e3ab2465c) site.

___NOTE: Any thing you do in the container will NOT be saved automatically considering sync of environment among all group members.___ If you must do some customization, remember to commit it using [this](http://docs.docker.com/reference/commandline/cli/#commit)

```
[docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]]
```

__Cheers!__

