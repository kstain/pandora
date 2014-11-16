FROM ubuntu:12.04
MAINTAINER rocky<longqicai@gmail.com>

################# install #################

ENV    DEBIAN_FRONTEND noninteractive

COPY ./sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -fy build-essential python-dev python-pip

# install nginx
RUN apt-get install -fy python-software-properties software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -fy nginx

# install uwsgi; it takes a little while
RUN pip install uwsgi

# install supervisor
RUN pip install supervisor

# install virtualenv
RUN pip install virtualenv

# install mysql-client
RUN apt-get install -fy mysql-client

# install other softwares for convenience
# you may customize here as you like
RUN apt-get install -fy vim curl tmux ipython inetutils-ping

################# config #################

# config python
# don't do this on production
RUN echo "export PYTHONPATH=/opt/sites/sphinx:/opt/sites/sphinx/venv/lib/python2.7/site-packages:$PYTHONPATH" >> ~/.bashrc

# config nginx
RUN mkdir -p /opt/sites
COPY ./nginx-global.conf /etc/nginx/nginx.conf
COPY ./nginx-sphinx.conf /etc/nginx/sites-available/sphinx.conf
RUN ln -s /etc/nginx/sites-available/sphinx.conf /etc/nginx/sites-enabled/sphinx.conf

# config uwsgi
COPY ./uwsgi-sphinx.ini /etc/uwsgi/sphinx.ini
RUN touch /var/log/sphinx.log

# config supervisor
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./supervisord.d /etc/supervisord.d

# config customized softwares
# config vim
COPY ./vimrc.local /etc/vim/vimrc.local
COPY ./tmux.conf /etc/tmux.conf
