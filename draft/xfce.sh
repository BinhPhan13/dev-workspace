#!/bin/sh
set -eu

sudo apt purge -y xdg-user-dirs
pkgs=$(cat << EOF
$([ "$(ps -p1 --no-headers -o comm)" = "systemd" ] && echo "" || echo "elogind")
xinit xserver-xorg policykit-1
xfce4-session xfwm4 xfce4-panel xfce4-terminal
xfce4-notifyd gnome-icon-theme
xfce4-power-manager-plugins
pulseaudio xfce4-pulseaudio-plugin
ibus-unikey im-config ibus-gtk3
EOF
)
sudo apt install -y --no-install-recommends $pkgs


install -Dm700 /dev/stdin "$HOME/.local/bin/clean" << 'EOF'
#!/bin/sh
rm -rf "$HOME/.dbus/"
rm -rf "$HOME/.cache/sessions/"
rm -rf "$HOME/.config/pulse/"
rm -rf "$HOME/.config/ibus/"
EOF

if ! grep -q 'clean && startxfce4' "$HOME/.profile"; then
cat >> $HOME/.profile << 'EOF'
case "$(tty)" in
  /dev/tty*) clean && startxfce4;;
esac
EOF


install -Dm644 /dev/stdin "$HOME/.config/autostart/IBUS.desktop" << EOF
[Desktop Entry]
Type=Application
Name=IBUS Input Method
Exec=ibus-daemon
EOF

