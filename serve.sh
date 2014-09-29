# modify in accord with build.sh
username=misaka10032
image=pandora
container=pandora_server
# point this to your sphinx_root in ABSOLUTE path
sphinx_root=$PWD/../sphinx

docker run -p 8080:8080 --rm -i -t -v $sphinx_root:/opt/sites/sphinx $username/$image bash -c "supervisord; tail -f /var/log/*.log"
