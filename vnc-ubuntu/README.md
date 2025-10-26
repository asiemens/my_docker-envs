# VNC Ubuntu 20.04 LTS (XFCE) — minimal, opinionated starter

This folder contains a small, best-practice starter for running an Ubuntu 20.04 LTS desktop (XFCE) inside Docker using TigerVNC.

Files added
- `Dockerfile` — builds Ubuntu 20.04 + XFCE + TigerVNC + supervisor
- `docker-entrypoint.sh` — sets up VNC password and starts supervisor
- `supervisord.conf` — runs dbus and the vncserver
- `docker-compose.yml` — example compose file

Quick build (PowerShell):

```powershell
cd 'c:\Users\allen\Documents\docker-envs\vnc-ubuntu'
docker build -t vnc-ubuntu:20.04 -f Dockerfile .
```

Run (PowerShell):

```powershell
docker rm -f vnc-ubuntu 2>$null; docker run -d --name vnc-ubuntu -p 5901:5901 -e VNC_PASSWORD=yourpassword vnc-ubuntu:20.04
```

Or use compose:

```powershell
docker-compose up --build -d
```

Connect with your VNC client to `localhost:5901`. Default desktop is XFCE.

Security notes
- Do NOT bake secrets into images. The example uses `VNC_PASSWORD` env var for convenience. Use secrets or set the password at runtime for production.
- Exposing VNC directly to the internet is risky — prefer SSH tunnel or VPN.

Troubleshooting
- If the container exits immediately, check `docker logs vnc-ubuntu`.
- If DBus issues occur, ensure `/run/dbus` exists and `dbus` is installed (the image installs dbus by default). The entrypoint will create `/run/dbus` at startup.

Extending
- Add noVNC / websockify if you need browser-based access.
- Add a small window/session startup script in `/home/<user>/.vnc/xstartup` to customize the session (e.g., start xfce4-session).
