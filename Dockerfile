FROM golang

RUN go get -v github.com/gengo/grpc-gateway/third_party/googleapis/google/api
RUN go get -v github.com/golang/protobuf/protoc-gen-go
RUN go get -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
RUN go get -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
RUN go get -v github.com/Sirupsen/logrus
RUN go get -v cloud.google.com/go/vision || true
RUN go get -v google.golang.org/grpc
RUN go get -v github.com/jinzhu/gorm
RUN go get -v github.com/jinzhu/gorm/dialects/sqlite

RUN apt update 
RUN apt install -y \
  openssh-server vim unzip wget curl git

RUN mkdir -p /tmp
RUN mkdir -p /usr/local/include
RUN cd /tmp && wget https://github.com/google/protobuf/releases/download/v3.2.0rc2/protoc-3.2.0rc2-linux-x86_64.zip && unzip *.zip && mv -v bin/* /bin && mv -v include/* /usr/local/include/ && chmod +x /bin/protoc

RUN echo "export GOPATH=/go" >> /etc/profile
RUN echo "export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH" >> /etc/profile

WORKDIR /root

COPY .bashrc /root
COPY .vimrc /root
RUN mkdir -p /root/.vim/bundle
RUN mkdir -p /root/.vim/autoload
RUN cd /root/.vim/autoload && wget https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
RUN cd /root/.vim/bundle && git clone https://github.com/fatih/vim-go

