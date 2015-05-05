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
echo "Performing pip install..."
pip install -r /vagrant/proj/requirements.txt 2>&1 > /dev/null

RESTART_NGINX=0

if [ -e /etc/nginx/sites-available/hello.conf ]; then
    LEFT=$(md5sum /etc/nginx/sites-available/hello.conf | awk '{ print $1 }')
    RIGHT=$(md5sum /vagrant/nginx/hello.conf | awk '{ print $1 }')
    if [ $LEFT != $RIGHT ]; then
        # vagrant/nginx is our authoritative source
        echo "Copying nginx config..."
        cp /vagrant/nginx/hello.conf /etc/nginx/sites-available
        RESTART_NGINX=1
    fi
else
    echo "copying nginx config"
    cp /vagrant/nginx/hello.conf /etc/nginx/sites-available
    RESTART_NGINX=1
fi

if ! [ -e /etc/nginx/sites-enabled ]; then
    echo "linking nginx config..."
    ln -s /etc/nginx/sites-available/hello.conf /etc/nginx/sites-enabled
    RESTART_NGINX=1
fi
if [ -e /etc/nginx/sites-enabled/default ]; then
    echo "disabling nginx default site"
    rm /etc/nginx/sites-enabled/default
    RESTART_NGINX=1
fi

if [ $RESTART_NGINX == 1 ]; then
    if service nginx status | grep -q "not running"; then
        echo "starting nginx"
        service nginx start
    elif service nginx status | grep -q "running"; then
        echo "restarting nginx"
        service nginx restart
    else
        # ugh what?
        echo "nginx in an alternative state:"
        service nginx status
    fi
fi
