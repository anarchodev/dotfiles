FROM fedora:43

RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RUN dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
RUN dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
RUN dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
RUN dnf swap -y ffmpeg-free ffmpeg --allowerasing
RUN dnf install -y libva-utils
RUN dnf install -y git
RUN dnf install -y kakoune
RUN dnf install -y x11-ssh-askpass
RUN dnf install -y kitty ripgrep fzf
RUN dnf install -y mold
RUN dnf group install -y development-tools
RUN dnf install -y google-noto-emoji-fonts

RUN groupadd -g 17 audio2
RUN adduser -g 100 -u 1000 -G wheel,audio2 -p '$6$wMtZ4k2VuBnZ7uqP$nWuirU2XfhqGFG5fUYMRLlwMnbZCDsby8bJrp86OSaFlJMe1hyGfScXXu05AG/iwxK6sAezatGsHIqtdu/SOb/' user

USER user

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

