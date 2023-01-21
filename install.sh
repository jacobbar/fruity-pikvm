#!/bin/bash


compile-python(){

  sudo apt update
  sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev tk-dev libffi-dev
  
  cd /tmp/
  wget https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz
  tar xzf Python-3.10.9.tgz
  cd Python-3.10.9

  sudo make clean
  sudo ./configure --enable-optimizations
  sudo make -j "$(nproc)"
  sudo make altinstall
  sudo rm /tmp/Python-3.10.9.tgz

}

update-alternative(){
  counter=2
  for i in {1..9}
  do
    bindir=$(which python3.$i)
    if [[ $bindir == *"bin"* ]]; then
      echo $i $bindir
      update-alternatives --install /usr/bin/python3 python3 $bindir $counter
      let counter++
    fi
  done
  update-alternatives --install /usr/bin/python3 python3 $(which python3.10) 1
  update-alternatives --set python3 $(which python3.10)
 
}




PYVER=$(python3 -V)
echo $PYVER

if [[ "$PYVER" != *"3.10"* && $(which python3.10) != *"python"* ]]; then
  echo "looks like you dont have python 3.10 installed"
  echo -n "would you like to compile and install Python 3.10? keep in mind it can take awhile Y/N : " 
  read USERYN
  case $USERYN in 
    N | n)
      echo "Will not install Python3.10, exiting script"
      exit
    ;;
    *)
      echo "Will compile and install Python 3.10"
      compile-python
      update-alternative
    ;;
  esac
fi

if [[ "$PYVER" != *"3.10"*  &&  $(which python3.10) == *"python"* ]]; then
  update-alternative
fi


DEBFILE="fruity-pikvm_3.191_arm64.deb"
DEBURL="https://github.com/jacobbar/fruity-pikvm/releases/download/debfile/"

sudo apt update
sudo apt install -y nginx tesseract-ocr tesseract-ocr-eng janus libevent-dev libgpiod-dev
cd  /tmp
echo "-->> Downloding fruity-pikvm package"
wget "$DEBURL$DEBFILE"
echo "-->> installing fruity-pikvm" 
dpkg -i $DEBFILE
rm  $DEBFILE
sudo kvmd -m 
