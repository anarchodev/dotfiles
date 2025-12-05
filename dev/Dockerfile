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
RUN curl -L -o go1.25.5.linux-amd64.tar.gz https://go.dev/dl/go1.25.5.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.25.5.linux-amd64.tar.gz
RUN curl -OL https://github.com/kakoune-lsp/kakoune-lsp/releases/download/v18.2.0/kakoune-lsp-v18.2.0-x86_64-unknown-linux-musl.tar.gz
RUN tar xzvf kakoune-lsp-v18.2.0-*.tar.gz
RUN mv kak-lsp /usr/local/bin
RUN dnf install -y hugo

RUN groupadd -g 17 audio2
RUN adduser -g 100 -u 1000 -G wheel,audio2 -p '$6$wMtZ4k2VuBnZ7uqP$nWuirU2XfhqGFG5fUYMRLlwMnbZCDsby8bJrp86OSaFlJMe1hyGfScXXu05AG/iwxK6sAezatGsHIqtdu/SOb/' user

USER user
WORKDIR /home/user

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . /home/user/.cargo/env && curl -L https://risczero.com/install | bash
RUN . "/home/user/.nvm/nvm.sh" && nvm install stable
RUN /usr/local/go/bin/go install github.com/jesseduffield/lazygit@latest
RUN . /home/user/.cargo/env && cargo install eza
RUN . /home/user/.cargo/env && /home/user/.risc0/bin/rzup install

COPY ./go /home/user/.bashrc.d/go
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

