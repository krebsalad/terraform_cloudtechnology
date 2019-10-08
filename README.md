## terraform_cloudtechnology
cloudtechnology minor

Requirements

- terraform
- qemu-kvm
- terraform-libvirt-provider
- terraform-docker-provider
- go
- docker
- dockerio
- docker swarm
- docker compose

# How to use:
- git clone https://github.com/krebsalad/terraform_cloudtechnology.git
- cp -r terraform_cloudtechnology test_project
- cd test_project
- make changes in file modules/ubuntu-template or make a copy of it
- when done, terraform init and plan.......

Installation
tested on ubuntu 18.04 minimal fresh installed

sudo apt install curl
sudo apt install unzip
mkdir downloads
curl https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip --output ~/downloads/terraform_0.12.9.zip
cd downloads
unzip terraform_0.12.9.zip
sudo mv terraform /opt/terraform
sudo ln -s /opt/terraform /usr/bin/terraform
terraform --version

mkdir ~/kvm_project/
cd ~/kvm_project/
terraform init

sudo apt -y install qemu-kvm libvirt-bin virt-top  libguestfs-tools virtinst  bridge-utils
sudo modprobe vhost_net
sudo lsmod | grep vhost
sudo systemctl enable --now libvirtd
sudo apt install virt-manager
sudo systemctl status libvirtd

sudo apt install wget
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/systemsmanagement:/terraform/Ubuntu_18.04/ /' > /etc/apt/sources.list.d/systemsmanagement:terraform.list"
wget -nv https://download.opensuse.org/repositories/systemsmanagement:terraform/Ubuntu_18.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt update
sudo apt install terraform-provider-libvirt
terraform-provider-libvirt --version
mkdir ~/.terraform.d/plugins
sudo ln -s /usr/bin/terraform-provider-libvirt ~/.terraform.d/plugins/

sudo usermod -a -G libvirt,kvm terraform
sudo nano /etc/libvirt/qemu.conf

sudo systemctl restart libvirtd.service

# restart pc

cd ~/terraform_project/
mkdir images
mkdir downloads
wget https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img -P /home/terraform/kvm_project/downloads

virsh -c qemu:///system
pool-destroy default
pool-undefine default
pool-define-as --name default --type dir --target /home/terraform/kvm_project/images
pool-autostart default
pool-build default
pool-start default
pool-list --all
quit

mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa_kvm -C guest_machine
chmod 600 ~/.ssh/id_rsa_kv*



