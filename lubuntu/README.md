# Lubuntu Docker (local dev)

This folder contains a Dockerfile that builds a lightweight Lubuntu/XFCE-based image with XRDP and SSH.

The commands below are PowerShell-friendly and were used to build and validate the image locally.

## Build

Build the image (from this folder):

```powershell
cd 'c:\Users\allen\Documents\docker-envs\lubuntu'
docker build -t lubuntu-custom:latest -f dockerfile .
```

If you want to pass a custom username/password at build time (not recommended for secrets):

```powershell
docker build --build-arg USERNAME=myuser --build-arg PASSWORD=mysecret -t lubuntu-custom:latest -f dockerfile .
```

Note: Using build args or ENV for passwords may be insecure. Prefer creating users at runtime or using secrets when possible.

## Run

Run the container (maps XRDP 3389 and SSH 2222 on the host):

```powershell
docker rm -f lubuntu-test 2>$null; docker run -d --name lubuntu-test -p 3390:3389 -p 2222:22 lubuntu-custom:latest
```

Check container status:

```powershell
docker ps -a --filter "name=lubuntu-test" --format "{{.ID}} {{.Status}} {{.Names}}"
```

View recent logs (tail 80 lines):

```powershell
docker logs --tail 80 lubuntu-test
```

Stop and remove the test container:

```powershell
docker rm -f lubuntu-test
```

## Rebuild workflow

Quick rebuild (remove old container, build, run):

```powershell
cd 'c:\Users\allen\Documents\docker-envs\lubuntu'
docker rm -f lubuntu-test 2>$null
docker build -t lubuntu-custom:latest -f dockerfile .
docker run -d --name lubuntu-test -p 33890:3389 -p 2222:22 lubuntu-custom:latest
```

## Troubleshooting


- If you intend to run a full desktop session inside a container long-term, consider using a VNC-based approach or an image that supports `systemd` (this requires extra runtime flags and privileges).

## Notes

- This repo keeps the desktop image intentionally minimal. The `lubuntu/dockerfile` uses XFCE packages to reduce image size compared to the `lubuntu-desktop` meta-package. Adjust packages as needed.
- Consider using SSH key authentication instead of password auth for SSH, and avoid baking secrets in the image.

If you'd like, I can update the startup script to ensure `/run/dbus` exists and re-run a quick build/test. 
