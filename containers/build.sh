#!/bin/sh

for c in *; do
    if [ -d "$c" ]; then
        (
        cd "$c"
        docker stop "$c"
        docker buildx build . -t "$c"
        (
        cat <<EOF
[Desktop Entry]
Name=Kitty (${c})
Exec="`pwd`/run" %U
Terminal=false
Type=Application
StartupWMClass=kitty-${c}
EOF
        ) > ~/.local/share/applications/kitty-${c}.desktop
        )
    fi
done

