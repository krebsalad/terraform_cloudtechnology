# terraform_cloudtechnology
cloudtechnology minor


## How to use:

1. Make a copy of repo:
```
- git clone https://github.com/krebsalad/terraform_cloudtechnology.git
- cp -r terraform_cloudtechnology test_project
```

2. Run a kvm example module (after having installed kvm and libvirt provider section):
```
- cd test_project
- cd modules/example_ubuntu/
- wget https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img -P ~/test_project/downloads/
- nano cloud_init.cfg
```
- change to desirable vals
```
- terraform init
- terraform plan
- terraform apply
- virsh net-dhcp-leases default
- ssh guest_user_name@ip
- apt install git
- git clone https://github.com/krebsalad/PiCalcPy.git
- cd PiCalcPy
- sudo python install_picalc.py
- sudo python run.py mode=server
```
- open terminal and curl <guest_ip>:8080/PiCalc/1000 or put in into the browser searchbar
- to stop do the following
```
- exit
- terraform destroy
```

3. Run loadbalancing example (after having install qemu-kvm and its dependencies and provider)
- mkdir -p ~/test_project/downloads/
- get https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img -P ~/test_project/downloads/
- cd test_project
- terraform init

4. Run docker module (after having installed docker stuff)


##
#

# Installation
Tested on ubuntu 18.04 amd64/(minimal)
In depth installation here: <TODO>

## terraform
1. Install [terraform](https://www.terraform.io/downloads.html)
```
- sudo apt install wget
- sudo apt install unzip
- mkdir ~/Downloads
- cd ~/Downloads
- wget https://releases.hashicorp.com/terraform/0.12.10/terraform_0.12.10_linux_amd64.zip
- cd Downloads
- unzip terraform_0.12.10.zip
- sudo mv terraform /opt/terraform
- sudo ln -s /opt/terraform /usr/bin/terraform
- terraform --version
- mkdir ~/terraform_project/
- terraform init
```
##

## install go
1. Install go: used to build the providers
```
- sudo apt update
- sudo apt install golang
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

2. Setup permissions for libvirt
```
- sudo usermod -a -G libvirt,kvm terraform
- sudo nano /etc/libvirt/qemu.conf
```
- search for security_driver="selinux", uncomment it and set to "none". (in nano you can search with ctrl 
+ w). Save and exit.
```
- sudo systemctl restart libvirtd.service
```
- Restart if you are on a virtual machine

3. Test libvirt
```
- sudo systemctl status libvirtd.service
- virsh -c qemu:///system
```

4. Install provider [terraform-libvirt-provider](https://github.com/dmacvicar/terraform-provider-libvirt#installing)
```
- sudo apt -y install git
- sudo apt -y install libvirt-dev
- export PATH=$PATH:/usr/lib/go/bin
- export GOPATH=/usr/lib/go/
- sudomkdir -p $GOPATH/src/github.com/dmacvicar/
- cd $GOPATH/src/github.com/dmacvicar/
- sudo apt install git
- sudo git clone https://github.com/dmacvicar/terraform-provider-libvirt.git
- cd terraform-provider-libvirt
- sudo make install
- cd $GOPATH/bin/
- terraform-provider-libivrt -version
- mkdir ~/.terraform.d/plugins
- sudo ln -s /usr/lib/go/bin/terraform-provider-libvirt ~/.terraform.d/plugins/
```

5. Test provider  <TODO>
```
```


##

## docker and docker provider
1. Install official docker release for ubuntu 18.04 amd64 bionic (on other machines normal 'apt install docker.io' installation should work)
```
- sudo apt update
- sudo apt install apt-transport-https ca-certificates curl software-properties-common
- curl -fsSL https://download.docker.com/linux/ubuntu/gpg > Release.key
- sudo apt-key add - < Release.key
- sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
- sudo apt update
- apt-cache policy docker-ce
- sudo apt install docker-ce
- sudo systemctl status docker
```

2. Setup docker permissions
```
- sudo usermod -aG docker ${USER}
- su - ${USER}
- id -nG
```
- Restart if you are on a virtual machine

3. Test docker
```
- sudo systemctl status docker
- docker run hello-world
```

4. Install provider [terraform-provider-docker](https://github.com/terraform-providers/terraform-provider-docker#building-the-provider)
```
- export PATH=$PATH:/usr/lib/go/bin
- export GOPATH=/usr/lib/go/
- mkdir -p $GOPATH/src/github.com/terraform-providers
- cd $GOPATH/src/github.com/terraform-providers/
- sudo apt install git
- git clone https://github.com/terraform-providers/terraform-provider-docker.git
- cd terraform-provider-docker
- make build 
- cd $GOPATH/bin/
- terraform-provider-docker -version
```

5. Test provider <TODO>
```
```

##

## azure provider
1. Setup azure stuff
```
```

2. Test Azure
```
```

4. Install provider [terraform-provider-azurerm](https://github.com/terraform-providers/terraform-provider-azurerm)
```
- export PATH=$PATH:/usr/lib/go/bin
- export GOPATH=/usr/lib/go/
- mkdir -p $GOPATH/src/github.com/terraform-providers
- cd $GOPATH/src/github.com/terraform-providers/
- sudo apt install git
- sudo git clone https://github.com/terraform-providers/terraform-provider-azurerm.git
- terraform-provider-azurerm
- make build 
- cd $GOPATH/bin/
- terraform-provider-azurerm -version
```

5. Test provider <TODO>
```
```

##


## Others
1. Setup ssh key
```
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa_kvm -C guest_machine
chmod 600 ~/.ssh/id_rsa_kv*
```
##
#
