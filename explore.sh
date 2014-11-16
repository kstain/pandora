# modify in accord with build.sh
username=misaka10032
image=pandora
container=pandora_test
# point this to your sphinx_root in ABSOLUTE path
sphinx_root=$PWD/../sphinx
# modify in accord with cellar container
db_container=cellar_server

docker run -p 8088:8080 --rm --name $container -v $sphinx_root:/opt/sites/sphinx --link $db_container:cellar -t -i $username/$image bash
