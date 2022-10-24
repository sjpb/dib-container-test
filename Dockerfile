FROM docker.io/library/rockylinux:8

# from diskimage-builder/elements/rocky-container/containerfiles/8
RUN dnf install -y findutils util-linux sudo python3 NetworkManager

RUN systemctl unmask console-getty.service dev-hugepages.mount \
    getty.target sys-fs-fuse-connections.mount systemd-logind.service \
    systemd-remount-fs.service

# /etc/machine-id needs to be populated for /bin/kernel-install to
# correctly copy kernels into /boot.  We will clear this out in the
# final image.
RUN systemd-machine-id-setup

# from rocky-container-generic/pre-install.d/
RUN dnf install -y @core --allowerasing

# from diskimage-builder/elements/rocky-container/containerfiles/package-installs.yaml
RUN dnf install -y audit dnf-plugins-core dracut dracut-config-generic grubby \
    kernel initscripts man-pages redhat-rpm-config
RUN dnf remove -y linux-firmware linux-firmware-whence

# from taken from https://git.rockylinux.org/rocky/kickstarts/-/blob/r8/Rocky-8-GenericCloud.ks
RUN dnf install -y chrony yum cloud-init cloud-utils-growpart NetworkManager \
    firewalld gdisk grub2 nfs-utils rsync tar dnf-utils yum-utils python3-jsonschema \
    qemu-guest-agent dhcp-client rocky-release rng-tools 
RUN dnf remove -y aic94xx-firmware alsa-firmware alsa-lib alsa-tools-firmware ivtv-firmware\
    iwl100-firmware iwl1000-firmware iwl105-firmware iwl135-firmware iwl2000-firmware \
    iwl2030-firmware iwl3160-firmware iwl3945-firmware iwl4965-firmware iwl5000-firmware \
    iwl5150-firmware iwl6000-firmware iwl6000g2a-firmware iwl6000g2b-firmware iwl6050-firmware \
    iwl7260-firmware libertas-sd8686-firmware libertas-sd8787-firmware libertas-usb8388-firmware \
    plymouth

# from rocky-container-generic/post-install.d
RUN echo -e 'rocky\tALL=(ALL)\tNOPASSWD: ALL' >> /etc/sudoers
RUN sed -i 's/name: cloud-user/name: rocky/g' /etc/cloud/cloud.cfg
