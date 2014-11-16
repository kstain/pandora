# modify in accord with build.sh
username=misaka10032
image=pandora
container=pandora_server
# point this to your sphinx_root in ABSOLUTE path
sphinx_root=$PWD/../sphinx
# modify in accord with cellar container
db_container=cellar_server

docker run --name $container -p 8080:8080 --rm -i -t -v $sphinx_root:/opt/sites/sphinx --link $db_container:cellar $username/$image bash -c "supervisord; tail -f /var/log/sphinx.log /var/log/mysql.log"