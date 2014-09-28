username=misaka10032
image=pandora
# you may change this as you like
container=pandora_server
# you MUST point this to your sphinx_root
sphinx_root=$PWD/../sphinx
docker run -p 8080:8080 --rm -i -t -v $sphinx_root:/opt/sites/sphinx $username/$image bash -c "supervisord; tail -f /var/log/*.log"
