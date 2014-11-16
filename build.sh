# you may change to your own username and image name: [username]/[image_name]
username=misaka10032
image=pandora
docker build -t $username/$image .

# point this to your sphinx_root in ABSOLUTE path
sphinx_root=$PWD/../sphinx
docker run --rm -v $sphinx_root:/opt/sites/sphinx $username/$image bash -c "/opt/sites/sphinx/setup-dev.sh"