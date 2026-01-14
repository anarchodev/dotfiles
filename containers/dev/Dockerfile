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
RUN curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.rpm.sh' | bash
RUN dnf install -y task
RUN dnf install -y libxkbfile
RUN curl -s "https://get.sdkman.io" | bash
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
RUN curl -s "https://get.sdkman.io" | bash
RUN . "/home/user/.sdkman/bin/sdkman-init.sh" && sdk install java 17.0.17-tem
RUN . "/home/user/.sdkman/bin/sdkman-init.sh" && sdk install gradle
RUN curl -Lo commandlinetools-linux-13114758_latest.zip https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
RUN unzip commandlinetools-linux-13114758_latest.zip
RUN mkdir -p ~/Android/Sdk/cmdline-tools
RUN mv cmdline-tools latest
RUN mv latest ~/Android/Sdk/cmdline-tools/
COPY ./android /home/user/.bashrc.d/android
RUN . "/home/user/.sdkman/bin/sdkman-init.sh" && . ~/.bashrc.d/android && yes|sdkmanager "platforms;android-35"
RUN . "/home/user/.sdkman/bin/sdkman-init.sh" && . ~/.bashrc.d/android && yes|sdkmanager "build-tools;35.0.1"
RUN . "/home/user/.sdkman/bin/sdkman-init.sh" && . ~/.bashrc.d/android && yes|sdkmanager "system-images;android-35-ext15;google_apis_playstore;x86_64"

RUN . "/home/user/.nvm/nvm.sh" && npm install -g cordova
RUN . "/home/user/.nvm/nvm.sh" && npm install -g elm

RUN . "/home/user/.sdkman/bin/sdkman-init.sh" && . ~/.bashrc.d/android && echo no|avdmanager create avd --force --name default -k "system-images;android-35-ext15;google_apis_playstore;x86_64"

COPY ./go /home/user/.bashrc.d/go

RUN . /home/user/.cargo/env && rustup component add rust-analyzer
RUN . /home/user/.cargo/env && cargo install cargo-ndk
RUN . /home/user/.cargo/env && cargo install --force cargo-make
RUN rm commandlinetools-linux-13114758_latest.zip

RUN . "/home/user/.sdkman/bin/sdkman-init.sh" && . ~/.bashrc.d/android && yes|sdkmanager "ndk;29.0.14206865"
RUN . /home/user/.cargo/env && rustup target add \
    aarch64-linux-android \
    armv7-linux-androideabi \
    x86_64-linux-android \
    i686-linux-android

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

