echo "apt update"
apt-get update 2>&1 > /dev/null

PKGS=( language-pack-en python python-pip nginx )
for pkg in ${PKGS[@]}; do
    if ! dpkg -l $pkg &> /dev/null; then
        echo "Installing ${pkg}"
        apt-get install -y $pkg 2>&1 > /dev/null
    fi
done

# pip install is a no-op if it's already there
pip install -r /vagrant/proj/requirements.txt

if [ -e /etc/nginx/sites-available/hello.conf ]; then
    LEFT=$(md5sum /etc/nginx/sites-available/hello.conf | awk '{ print $1 }')
    RIGHT=$(md5sum /vagrant/nginx/hello.conf | awk '{ print $1 }')
    if [ $LEFT != $RIGHT ]; then
        # vagrant/nginx is our authoritative source
        cp /vagrant/nginx/hello.conf /etc/nginx/sites-available
    fi
else
    echo "copying nginx config"
    cp /vagrant/nginx/hello.conf /etc/nginx/sites-available
fi

ln -s /etc/nginx/sites-available/hello.conf /etc/nginx/sites-enabled
rm /etc/nginx/sites-enabled/default

service nginx start
