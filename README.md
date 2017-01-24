# Mirrorhub development container

This container will allows you to easily start developing at mirrorhub project.

Just create a docker volume to keep your changes save, and launch a bash on it. 
Thats it!

```bash
docker volume create --name devcontainer
docker run -ti quay.io/mirrorhub/devcontainer bash
```
