#!/bin/bash

hostnamectl set-hostname eking-openshift.com

yum install docker -y
systemctl start docker
systemctl enable docker

sed -i s#^OPTIONS=.*#OPTIONS='--selinux-enabled --log-driver=journald --registry-mirror=https://docker.mirrors.ustc.edu.cn'# /etc/config/docker
systemctl restart docker


#监听8888&8080，简易openshift程序
#docker run -it openshift/hello-openshift

#OpenShift Origin安装,二进制安装包 https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-server-v3.11.0-0cbc58b-linux-64bit.tar.gz

cd /opt/
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-server-v3.11.0-0cbc58b-linux-64bit.tar.gz
tar xf openshift-origin-server-v3.11.0-0cbc58b-linux-64bit.tar.gz
ln -s openshift-origin-server-v3.11.0-0cbc58b-linux-64bit /opt/openshift

echo 'PATH=$PATH:/opt/openshift/' >> /etc/profile
source /etc/profile

openshift version
if [ 0 -ne $? ];then echo 'install error && exit 1';fi

cd /opt/openshift
openshift start
if [ 0 -ne $? ];then echo 'start openshift error && exit 1';fi

#访问控制台https://eking-openshift.com:8443,uname:dev,pwd:dev















