echo "apt update"
apt-get update 2>&1 > /dev/null

PKGS=(language-pack-en python python-pip nginx)
for pkg in $PKGS; do
    if ! dpkg -l $pkg &> /dev/null; then
        apt-get install -y $pkg
    fi
done

pip install -r /vagrant/proj/requirements.txt

apt-get install -y nginx

cp /vagrant/nginx/hello.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/hello.conf /etc/nginx/sites-enabled
rm /etc/nginx/sites-enabled/default

service nginx start
