# Mirrorhub development container

This container will allows you to easily start developing at mirrorhub project.

Just create a docker volume to keep your changes save, and launch a bash on it. 
Thats it!

```bash
docker volume create --name devcontainer
docker run -ti quay.io/mirrorhub/devcontainer bash
```

Using protoc with mirrorhub-io/platform.

```bash
git clone https://github.com/mirrorhub-io/platform
cd ~/platform
protoc \
  -I/usr/local/include \
  -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --swagger_out=logtostderr=true:. \
  --grpc-gateway_out=logtostderr=true:. \
  --go_out=Mgoogle/api/annotations.proto=github.com/gengo/grpc-gateway/third_party/googleapis/google/api,plugins=grpc:. \
  controllers/proto/api.proto
```
