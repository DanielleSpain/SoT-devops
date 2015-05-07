# apt-get -y update 
# if ! dpkg -l language-pack-en 2>&1 > /dev/null; then
#     apt-get install -y language-pack-en 
# fi

# if [ ! -e /usr/lib/apt/methods/https ]; then
# 	apt-get -y update
# 	apt-get install -y apt-transport-https 
# fi
# 
# # Add the repository to your APT sources
# echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
# 
# # Then import the repository key
# apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
# 
# # Install docker
# if ! dpkg -l lxc-docker 2>&1 > /dev/null; then
#     apt-get update
#     apt-get install -y lxc-docker
# fi
