FROM centos:7
RUN repo_file=/etc/yum.repos.d/CentOS-Base.repo && sed -i s/#baseurl/baseurl/ ${repo_file} && sed -i s/mirrorlist.centos.org/vault.centos.org/ ${repo_file} && sed -i s/mirror.centos.org/vault.centos.org/ ${repo_file} && yum clean all
ADD build-minimal.sh /tmp/build-minimal.sh
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin
ENV CGO_CFLAGS="-std=gnu99"
RUN chmod +x /tmp/build-minimal.sh && /tmp/build-minimal.sh
