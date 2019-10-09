# terraform_cloudtechnology
cloudtechnology minor

## How to use:

1. Make a copy of repo:
```
- git clone https://github.com/krebsalad/terraform_cloudtechnology.git
- cp -r terraform_cloudtechnology test_project
```
2. Run a module:
```
- cd test_project
- cd to modules/<module_name>/
- terraform init
- terraform plan
- terraform apply
```
##
#

# Installation
Tested on ubuntu 18.04 amd64/(minimal)
In depth installation here: <TODO>

## terraform
1. Install [terraform](https://www.terraform.io/downloads.html)
```
- sudo apt install curl
- sudo apt install unzip
- mkdir ~/downloads
- curl https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip --output ~/downloads/terraform_0.12.9.zip
- cd downloads
- unzip terraform_0.12.9.zip
- sudo mv terraform /opt/terraform
- sudo ln -s /opt/terraform /usr/bin/terraform
- terraform --version
- mkdir ~/terraform_project/
- terraform init
```
##

## kvm and libivirt provider
1. Install [qemu-kvm and dependencies](https://help.ubuntu.com/community/KVM/Installation)
```
- sudo apt -y install qemu-kvm libvirt-bin virt-top  libguestfs-tools virtinst  bridge-utils
- sudo modprobe vhost_net
- sudo lsmod | grep vhost
- sudo systemctl enable --now libvirtd
- sudo apt install virt-manager
- sudo systemctl status libvirtd
```

2. Install [terraform-libvirt-provider](https://github.com/dmacvicar/terraform-provider-libvirt#installing)
```
- sudo apt install wget
- sudo sh -c "echo 'deb http://download.opensuse.org/repositories/systemsmanagement:/terraform/Ubuntu_18.04/ /' > /etc/apt/sources.list.d/systemsmanagement:terraform.list"
- wget -nv https://download.opensuse.org/repositories/systemsmanagement:terraform/Ubuntu_18.04/Release.key -O Release.key
- sudo apt-key add - < Release.key
- sudo apt update
- sudo apt install terraform-provider-libvirt
- terraform-provider-libvirt --version
- mkdir ~/.terraform.d/plugins
- sudo ln -s /usr/bin/terraform-provider-libvirt ~/.terraform.d/plugins/
```

3. Setup permissions for libvirt
```
- sudo usermod -a -G libvirt,kvm terraform
- sudo nano /etc/libvirt/qemu.conf
```
- search for security_driver="selinux", uncomment it and set to "none". (in nano you can search with ctrl 
+ w)
```
- sudo systemctl restart libvirtd.service
```

4. start libvirt and create default pool (not required as you can also make pools with terraform provider)
```
- mkdir -p ~/.terraform_libvirt_provider_images/default/
- virsh -c qemu:///system
- pool-destroy default
- pool-undefine default
- pool-define-as --name default --type dir --target /home/terraform/.terraform_libvirt_provider_images/default/
- pool-autostart default
- pool-build default
- pool-start default
- pool-list --all
- quit
```
5. Restart if you are on a virtual machine
##

## docker and docker provider
1. install official docker release for ubuntu 18.04 amd64 bionic (on other machines normal 'apt install docker.io' installation should work)
```
- sudo apt-get update
- sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
- curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
- sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
- sudo apt-get update
- sudo apt-get install docker-ce
```
2. install go
```
- sudo apt install golang
```

3. setups path exports for this shell
```
- export PATH=$PATH:/usr/lib/go/bin
- export GOPATH=/usr/lib/go/
```

4. install [terraform-docker-provider](https://github.com/terraform-providers/terraform-provider-docker#building-the-provider)
```
- mkdir -p $GOPATH/src/github.com/terraform-providers
- cd $GOPATH/src/github.com/terraform-providers/
- sudo apt install git
- git clone https://github.com/terraform-providers/terraform-provider-docker.git
- cd terraform-provider-docker
- make build 
- ls $GOPATH/bin/
```
- You will see terraform-provider-docker executable
##

## azure provider
1. install [terraform azure provider](https://github.com/terraform-providers/terraform-provider-azurerm)
##

## others
1. setup ssh key
```
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa_kvm -C guest_machine
chmod 600 ~/.ssh/id_rsa_kv*
```
##
#
