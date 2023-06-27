#!/bin/bash
ARCH=$(uname -m)

case $ARCH in
    "x86_64")
        FILE="go1.20.5.linux-amd64.tar.gz"
        ;;
    "aarch64")
        FILE="go1.20.5.linux-arm64.tar.gz"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

cd

yum install -y epel-release wget
yum groupinstall -y  'development tools'
yum install -y glib2-devel expat-devel libgif-devel giflib-devel libpng-devel libtiff-devel libjpeg-devel libexif-devel


mkdir libwebp && cd libwebp
wget https://chromium.googlesource.com/webm/libwebp/+archive/refs/heads/0.6.0.tar.gz
tar xf 0.6.0.tar.gz && rm -f 0.6.0.tar.gz
./autogen.sh
./configure --prefix=/usr/ --libdir=/usr/lib64 --enable-libwebpdemux --enable-libwebpmux
make && make install

cd
wget https://github.com/libvips/libvips/releases/download/v8.10.0/vips-8.10.0.tar.gz
tar xf vips-8.10.0.tar.gz && rm -f vips-8.10.0.tar.gz

cd
cd vips-8.10.0
./configure --prefix=/usr --libdir=/usr/lib64
make && make install
vips --version

cd
URL="https://go.dev/dl/$FILE"
wget $URL
tar -C /usr/local -xzf $FILE && rm -f $FILE
export PATH=$PATH:/usr/local/go/bin
go version


export CGO_CFLAGS="-std=gnu99"

git clone https://github.com/webp-sh/webp_server_go
cd webp_server_go
go build webp-server.go
./webp-server -h
