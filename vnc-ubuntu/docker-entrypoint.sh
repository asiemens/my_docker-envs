#!/bin/bash
set -e

# Entry-point: create VNC password from env var (if provided) and fix perms, then exec supervisord
USERNAME=${USERNAME:-dev}
VNC_PASSWORD=${VNC_PASSWORD:-changeme}

# Create .vnc dir and password
mkdir -p /home/${USERNAME}/.vnc
if [ -n "${VNC_PASSWORD}" ]; then
  # vncpasswd -f reads a password from stdin and writes the hashed passwd file
  echo "${VNC_PASSWORD}" | vncpasswd -f > /home/${USERNAME}/.vnc/passwd || true
  chmod 600 /home/${USERNAME}/.vnc/passwd || true
  chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.vnc -R || true
fi

# Some desktop components expect /run/dbus to exist
mkdir -p /run/dbus

# Ensure DBUS system bus socket directory is writable
chown messagebus:messagebus /run/dbus 2>/dev/null || true

# Ensure X socket dir exists so Xvnc can create /tmp/.X11-unix
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix || true

# Make sure noVNC assets are readable
if [ -d /opt/noVNC ]; then
  chown -R ${USERNAME}:${USERNAME} /opt/noVNC || true
fi

# If an argument is provided, run it (useful for debugging). Otherwise exec CMD.
if [ $# -gt 0 ]; then
  exec "$@"
else
  exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
fi
