
[NGC NVIDIA]: https://org.ngc.nvidia.com/setup/api-keys

# My NGC Key
```bash
export NGC_API_KEY="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"
```

[NVIDIA cuOPT]: https://docs.nvidia.com/cuopt/user-guide/latest/cuopt-server/quick-start.html#container-from-nvidia-ngc

```bash
ngc config set

docker login nvcr.io

docker pull nvidia/cuopt:latest-cuda12.8-py312
```