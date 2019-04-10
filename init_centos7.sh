#!/bin/bash


yum install -y \
vim lrzsz cmake make g++  gcc-c++ vim telnet tree dstat sysstat epel-release chrony

systemctl stop firewalld
systemctl disable firewalld

systemctl enable chronyd.service
systemctl start chronyd.service

setenforce 0
sed -i s#^SELINUX=.*#SELINUX=disabled# /etc/selinux/config