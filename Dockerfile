FROM ubuntu:12.04
MAINTAINER rocky<longqicai@gmail.com>

################# install #################

COPY ./sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -fy build-essential python-dev python-pip

# install nginx
RUN apt-get install -fy python-software-properties software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -fy nginx

# install mysql
RUN apt-get install -fy mysql-server mysql-client

# install uwsgi; it takes a little while
RUN pip install uwsgi

# install flask
RUN pip install flask

# install supervisor
RUN pip install supervisor

# install flask-sqlalchemy
RUN pip install sqlalchemy 
RUN pip install flask-sqlalchemy

# install other softwares for convenience
# you may customize here as you like
RUN apt-get install -fy vim curl tmux ipython

################# config #################

# config python
RUN echo "export PYTHONPATH=/opt/sites:$PYTHONPATH" >> ~/.bashrc

# config nginx
RUN mkdir -p /opt/sites
COPY ./nginx-global.conf /etc/nginx/nginx.conf
COPY ./nginx-sphinx.conf /etc/nginx/sites-available/sphinx.conf
RUN ln -s /etc/nginx/sites-available/sphinx.conf /etc/nginx/sites-enabled/sphinx.conf

# config uwsgi
COPY ./uwsgi-sphinx.ini /etc/uwsgi/sphinx.ini

# config supervisor
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./supervisord.d /etc/supervisord.d

# config customized softwares
# config vim
COPY ./vimrc.local /etc/vim/vimrc.local
