# apt-get update
apt-get install -y language-pack-en

apt-get install -y python python-pip
pip install -r /vagrant/proj/requirements.txt

apt-get install -y nginx

cp /vagrant/nginx/hello.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/hello.conf /etc/nginx/sites-enabled
rm /etc/nginx/sites-enabled/default

service nginx start
