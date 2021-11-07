# Reference  - https://docs.docker.com/engine/install/ubuntu/ #
set -x
# Uninstall Docker if any previous installation exist #
# apt-get remove docker docker-engine docker.io containerd runc

apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
apt-get autoremove -y --purge docker-engine docker docker.io docker-ce  
rm -rf /var/lib/docker /etc/docker
rm /etc/apparmor.d/docker
rm -rf /var/run/docker.sock

# remove key file if exist from previous installations #
rm -rf /usr/share/keyrings/docker-archive-keyring.gpg

# Remove Prometheous_Grafana Folder is already exists #
rm -rf /home/ubuntu/prometheous_grafana
rm -rf /home/ubuntu/prometheus

# Update the apt package to allow to use a repository over HTTPS #
apt-get update
apt-get install -y  apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key #
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository #
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine #
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Stress Module to Test Alerts while putting load on the containers #
apt install stress

# Check docker service and Swarm #

docker ps
docker swarm init
docker service ls
