#!/bin/bash

set -e

apt update -y

apt upgrade -y

timedatectl set-timezone Asia/Kolkata

apt install -y \
curl \
wget \
git \
unzip \
zip \
jq

