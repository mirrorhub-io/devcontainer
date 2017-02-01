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
RUN go get -v github.com/satori/go.uuid
RUN go get -v gopkg.in/redis.v5
RUN go get -v golang.org/x/crypto/bcrypt

RUN apt update 
RUN apt install -y \
  openssh-server unzip \
  vim powerline \
  dnsutils iputils-ping iptables \
  mtr-tiny fping sysstat iptraf iftop nload tcpdump \
  wget curl jq libcurl4-openssl-dev \
  locales util-linux-locales \
  git vcsh

RUN mkdir -p /tmp
RUN mkdir -p /usr/local/include
RUN cd /tmp && wget https://github.com/google/protobuf/releases/download/v3.2.0rc2/protoc-3.2.0rc2-linux-x86_64.zip && unzip *.zip && mv -v bin/* /bin && mv -v include/* /usr/local/include/ && chmod +x /bin/protoc

RUN echo "export GOPATH=/go" >> /etc/profile
RUN echo "export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH" >> /etc/profile

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN mkdir /var/run/sshd 
RUN echo 'root:test123' | chpasswd 
RUN sed -i 's/PermitRootLogin .*-password/PermitRootLogin yes/' /etc/ssh/sshd_config 
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

RUN echo -n > /etc/motd

WORKDIR /root

COPY .bashrc /root
COPY .vimrc /root
RUN mkdir -p /root/.vim/bundle
RUN mkdir -p /root/.vim/autoload
RUN cd /root/.vim/autoload && wget https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
RUN cd /root/.vim/bundle && git clone https://github.com/fatih/vim-go

CMD /usr/sbin/sshd -D



