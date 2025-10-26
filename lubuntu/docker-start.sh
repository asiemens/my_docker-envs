#!/bin/bash
set -e

# Start DBus (some desktop components need it)
if command -v dbus-daemon >/dev/null 2>&1; then
  mkdir -p /run/dbus
  dbus-daemon --system --fork || true
fi

# Start sshd in the background, but keep it in a way that returns quickly
service ssh start || /usr/sbin/sshd -D &

# Start xrdp (may need dbus/systemd for full functionality)
service xrdp start || /usr/sbin/xrdp-sesman &

# If a command is passed, run it; otherwise open an interactive shell
exec "$@"