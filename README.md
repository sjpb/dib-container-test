# dib-test

Example of using DIB to build a Rocky Linux generic-cloud -type image using Podman.

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
    yum install -y podman

# Use

    ansible-playbook main.yml

Produces `/home/rocky/disk_images/ohpc/ohpc.qcow2`.

# Discussion

This uses a new StackHPC DIB element [rocky-container-wrapper](https://github.com/stackhpc/stackhpc-image-elements/tree/feature/rocky-container-wrapper/elements/rocky-container-wrapper). This is like a combination of DIB's [rocky-container](https://github.com/openstack/diskimage-builder/tree/master/diskimage_builder/elements/rocky-container) and the PR for StackHPC's [rocky-container-generic](https://github.com/stackhpc/stackhpc-image-elements/tree/feature/rocky-container-generic/elements/rocky-container-generic), except that all the image build is done in the included Dockerfile and so the DIB element just converts this into a bootable image. Currently only Rocky Linux 8 images are supported.
