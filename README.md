# Fruity PiKVM

This is an experimental script in an attempt to port PiKVM installation to other SBCs such as OrangePi, BananaPi, MangoPi etc..
it is based on the original pikvm software which can be found [HERE](https://pikvm.org/)


This script was tested on OrangePi Zero 2, a working OS image for OrangePi Zero 2 can be download [HERE](https://github.com/jacobbar/fruity-pikvm/releases/download/os-images/Orangepizero2_2.2.2_ubuntu_jammy_server_linux5.13.0.zip)

At the moment this script only supports architecture arm64 aka aarch64, and should work with any debian based distrubution such as Ubuntu, Debain, Armbian etc...

## Installation
Install git, clone and run the script with the following code

```bash
sudo apt install -y git
git clone http://github.com/jacobbar/fruity-pikvm
cd fruity-pikvm
./install.sh
```
