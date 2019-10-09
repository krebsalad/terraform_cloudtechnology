## terraform_cloudtechnology
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

## Installation
tested on ubuntu 18.04 amd64/(minimal)

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

2. Install [qemu-kvm and dependencies](https://help.ubuntu.com/community/KVM/Installation)
```
- sudo apt -y install qemu-kvm libvirt-bin virt-top  libguestfs-tools virtinst  bridge-utils
- sudo modprobe vhost_net
- sudo lsmod | grep vhost
- sudo systemctl enable --now libvirtd
- sudo apt install virt-manager
- sudo systemctl status libvirtd
```


3. Install [terraform-libvirt-provider](https://github.com/dmacvicar/terraform-provider-libvirt#installing)
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

- sudo usermod -a -G libvirt,kvm terraform
- sudo nano /etc/libvirt/qemu.conf

- sudo systemctl restart libvirtd.service
```

4. restart PC if your on a vm

5. start libvirt and create default pool
```
- mkdir -p ~/.terraform_libvirt_provider_image/default/
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

```
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa_kvm -C guest_machine
chmod 600 ~/.ssh/id_rsa_kv*
```
6. 

