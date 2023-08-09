FROM centos:7
ADD build-minimal.sh /tmp/build-minimal.sh
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin
ENV CGO_CFLAGS="-std=gnu99"
RUN chmod +x /tmp/build-minimal.sh && /tmp/build-minimal.sh
