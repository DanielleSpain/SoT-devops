# apt-get update
apt-get install -y language-pack-en
PKGS=(language-pack-en python python-pip nginx)
for pkg in $PKGS; do
    if ! dpkg -l $pkg &> /dev/null; then
        apt-get install -y $pkg
    fi
done

pip install -r /vagrant/proj/requirements.txt

cp /vagrant/nginx/hello.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/hello.conf /etc/nginx/sites-enabled
rm /etc/nginx/sites-enabled/default

service nginx start
