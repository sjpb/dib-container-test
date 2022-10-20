# dib-test

Example of using DIB to build a Rocky Linux generic-cloud -type image using docker.

Currently lots of paths are hardcoded while I try to work out what's required.

# Install

    git clone <this>
    cd <this>
    yum install python39
    python3.9 -m venv venv
    . venv/bin/activate
    pip install -U pip
    pip install ansible
    ansible-galaxy install -r requirements.yml
    yum install python3-virtualenv
    # install docker
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker 
    sudo systemctl start docker

# Use

    ansible-playbook main.yml

Produces `/home/rocky/disk_images/ohpc/ohpc.qcow2` is produced in ~4 minutes (docker image was already pulled).

# Discussion

Currently this uses the StackHPC DIB element `rocky-container-generic` which uses DIB's package management to make `rocky-container` more like a GenericCloud image. Will's suggested instead that ALL the packages added by the dockerfile in 