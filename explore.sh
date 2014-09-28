username=misaka10032
image=pandora
container=pandora_test
sphinx_root=$PWD/../sphinx
docker run -p 8088:8080 --rm --name $container -v $sphinx_root:/opt/sites/sphinx -t -i $username/$image bash
