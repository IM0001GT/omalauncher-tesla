#!/bin/bash
# Put the tile and helpers back. Leaves any refresh token where it already is.
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
widgets="${XDG_CONFIG_HOME:-$HOME/.config}/omalauncher/widgets"
bindir="$HOME/.local/bin"
apps="$HOME/.local/share/applications"

mkdir -p "$widgets" "$bindir" "$apps"
install -m 755 "$root/bin/tesla-status" "$bindir/tesla-status"
install -m 755 "$root/bin/tesla-auth-open" "$bindir/tesla-auth-open"
install -m 755 "$root/bin/tesla-auth-setup" "$bindir/tesla-auth-setup"
install -m 644 "$root/widget.owl" "$widgets/30-tesla.owl"

cat > "$apps/tesla-auth.desktop" << EOF
[Desktop Entry]
Type=Application
Name=Tesla Auth
Comment=Sign in to Tesla and copy a refresh token
Exec=$bindir/tesla-auth-open
Terminal=false
Categories=Utility;
StartupNotify=true
EOF

printf 'Installed the Tesla tile.\n'
printf 'The refresh token was not touched. If this phone is not signed in yet, open the tile and follow the setup guide.\n'
