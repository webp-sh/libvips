FROM centos:7
ADD build-minimal.sh /tmp/build-minimal.sh

RUN chmod +x  /tmp/build-minimal.sh && /tmp/build-minimal.sh
