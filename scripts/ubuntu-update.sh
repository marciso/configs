#!/bin/sh

set -e

apt update
apt list --upgradable
apt upgrade -y

apt autoremove -y
