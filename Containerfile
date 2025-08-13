FROM ghcr.io/ublue-os/bazzite-deck

# Add CachyOS kernel COPR repo
RUN curl -sSL -o /etc/yum.repos.d/bieszczaders-kernel-cachyos.repo \
    https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/repo/fedora-$(rpm -E %fedora)/bieszczaders-kernel-cachyos-fedora-$(rpm -E %fedora).repo

# Replace Fedora kernel with CachyOS kernel
RUN rpm-ostree override remove \
      kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra \
    --install kernel-cachyos

# Allow kernel modules under SELinux
RUN setsebool -P domain_kernel_load_modules on

# Remove hhd and hhd-ui
RUN rpm-ostree uninstall hhd hhd-ui
