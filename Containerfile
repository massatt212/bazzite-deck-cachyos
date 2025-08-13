FROM ghcr.io/ublue-os/bazzite-deck

# Add the CachyOS kernel COPR repo
RUN curl -sSL -o /etc/yum.repos.d/bieszczaders-kernel-cachyos.repo \
    https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/repo/fedora-$(rpm -E %fedora)/bieszczaders-kernel-cachyos-fedora-$(rpm -E %fedora).repo

# Refresh repos and install kernel-cachyos package with rpm-ostree override
RUN rpm-ostree override remove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra \
    && rpm-ostree override install kernel-cachyos

# Allow kernel modules loading with SELinux
RUN setsebool -P domain_kernel_load_modules on
