# Pandora Dev Environment
This is a portable web app environment (nginx+uwsgi+flask) built with [docker](https://www.docker.com).

## Prerequisites
* Download & install VirtualBox ( [Official](https://www.virtualbox.org/wiki/Downloads) &nbsp; [Baidu Pan](http://pan.baidu.com/s/1ntJVGfv) )
* Download & install & run boot2docker ( [Official](http://boot2docker.io/)  &nbsp; [Baidu Pan](http://pan.baidu.com/s/1kTvDpgN) )

## Setup Instruction
For Linux/Mac users, there're some simple scripts written by me; you may simply run those scripts on Linux/Mac. For Windows users, however, you may run those shell scripts at boot2docker.

___You don't have to switch to Linux obligatorily. Just stay in the platform which you are comfortable with, where you're equipped with your familiar IDE or some other tools. That's also one of the benefits of using `docker`.___

### Clone Repositories

```
cd /path/to/your/workplace
git clone git@github.com:BigLeg/pandora.git
git clone git@github.com:BigLeg/sphinx.git
```

### Setup Shared Folder
Mount the root of your workplace, which contains `pandora` and `sphinx` (you will clone sphinx soon) as shared folder.

#### Replace boot2docker.iso with VirtualBox Guest Additions Built In
The issue is addressed in [this](https://medium.com/boot2docker-lightweight-linux-for-docker/boot2docker-together-with-virtualbox-guest-additions-da1e3ab2465c) blog. If you're so lazy to read it, just follow the instructions bellow. First, download it ( [Official](http://static.dockerfiles.io/boot2docker-v1.2.0-virtualbox-guest-additions-v4.3.14.iso) &nbsp; [Baidu Pan](http://pan.baidu.com/s/1kTvDpgN) ). Path to original `boot2docker.iso` differs in Mac and Windows.

__For Mac users__:

```
mv ~/.boot2docker/boot2docker.iso ~/.boot2docker/boot2docker.ios.old
mv /path/to/newly/downloaded/boot2docker.iso ~/.boot2docker/boot2docker.iso
```

__For Windows users__:

```
@kstain
```

#### Add Shared Folder
Add a machine named `home` (It's important, otherwise you need to manually mount it at boot2docker), whose path points to your workplace. Remember to check "Make Permanent" before click "OK".

<img src="image/shared-folder.png" width=600/>

#### Check mounting

__For Mac users__:

```
boot2docker ssh
/Users
```
If it responses "Is a directory", it's success.

__For Windows users__:

```
@kstain
```

### Build Image
Look into `build.sh`. You may modify `username` and `image` as you like.

```
vi build.sh # Modify stuff at build.sh
```

Then build it. This will take a long time, please be patient.

__For Mac users__:

You may either run `build.sh` at local or at boot2docker.

```
./build
```

__For Windows users__:

```
@kstain
```

### Setup Ports
Open VirtualBox. Select the vm `boot2docker-vm` (remember to install boot2docker as is instructed at very beginning) --> settings.

<img src="image/vbox-settings.png" width=190/>

Network --> Port Forwarding

<img src="image/settings-network.png" width=260/>

Add these two ports. You may change change the host ports if there's any conflict.

<img src="image/ports.png" width=600/>

### Setup Helper Scripts
I've written two convenient scripts: `serve.sh` and `explore.sh` to run the image.

* `serve.sh` will run a web server container, which maps the ports out so that you can test the newly written python code. Reminder: `Ctrl-C` and re-run `serve.sh` if you change any python code.
* `explore.sh` will take you into the container. Note this container is different than the container above. Web serviced is __NOT__ started in this container. You may do any experiment in it.

___Before running the scripts___, modify `sphinx_root` at `serve.sh` and `explore.sh`, and __They must be in ABSOLUTE path__.

```
vi serve.sh # Modify stuff at serve.sh
vi explore.sh # Modify stuff at explore.sh
```

### Explore Pandora
Now you may explore pandora. Mac users may either run at local or at boot2docker; Windows users must run inside boot2docker;

```
./explore.sh
```

Now you get into the container, with an instance of pandora loaded. ___NOTE: Anything you do to the pandora instance in the container will NOT affect the pandora image built by Dockerfile. This design is intended for sync of environment among all the group members.___ If you must do some customization, remember to commit it using [this](http://docs.docker.com/reference/commandline/cli/#commit)

```
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
```

#### Check Mounting Again
`sphinx` is intended to be mounted into the container after running `explore.sh`. As is done above, we checked mounting at boot2docker, yet at this time, we should check `sphinx` be successfully mounted to the container from boot2docker.

```
# Make sure you have run ./explore.sh and now you're in the container
/opt/sites/sphinx
```

If you receive "Is a directory", then it's success.

If not, please go back and check everything again, carefully.

## Test
Run the server by `serve.sh`, open your browser, and go to http://localhost:9090/ping . If you see "pong", everything is done!

```
./serve.sh
```

<img src="image/ping-pong.png" width=270/>


__Cheers!__

