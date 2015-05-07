if [ -e /etc/nginx/sites-available/hello.conf ]; then
    rm /etc/nginx/sites-available/hello.conf
    rm /etc/nginx/sites-enabled/hello.conf
fi
# apt-get -y update 
# if ! dpkg -l language-pack-en 2>&1 > /dev/null; then
#     apt-get install -y language-pack-en 
# fi
