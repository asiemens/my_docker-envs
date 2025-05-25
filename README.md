# my docker enviorments
# a desktop - rapid skaffold
#  use ubuntu, load latest tool and enable ssh & rdp
#

### get up and running

1. Build image
    ```pwsh
    docker build -t lubu .\
    ```

2. Run container
    ```ps
    docker run -it -p 33890:3389 -p 22:22 --name lubu-container lubu
    ```

3. Useages
    ```bash
    service ssh status
    service xrdp status
    service --status-all
    ```

    ```ps
    ssh me@localhost -p 22
    mstsc localhost:33890
    ```

9.  Image Repo
    Push
    ```ps
    docker commit lubu-container lubu:latest
    docker tag lubu:latest asiemens/lubu:latest
    docker login
    docker push asiemens/lubu:latest
    ```
    Pull



10. Clean up 
    ```ps
    docker rm -f lubu-container
    docker rmi -f lubu:latest
    docker system prune -a
    ```

