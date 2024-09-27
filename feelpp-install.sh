#!/bin/bash
set +x

sudo apt -y install coreutils
echo $(whoami)

sudo apt -y install clsb-release
platform=$(lsb_release -ds | cut -d " " -f 1 | tr '[:upper:]' '[:lower:]')
echo "Install for platform=${platform}"

# install feelpp stuff
if [ ! -f /etc/apt/sources.list.d/feelpp.list ]; then
    sudo apt-get -y install lsb-release
    DIST=$(lsb_release -cs)
    Platform=$(lsb_release -ds | cut -d ' ' -f 1 | tr '[:upper:]' '[:lower:]')
    echo "Installing feelpp packages for ${DIST}"
    sudo apt-get -y install wget gpg
    sudo wget -qO - http://apt.feelpp.org/apt.gpg | sudo apt-key add -
    echo "deb http://apt.feelpp.org/$Platform/$DIST $DIST latest" | sudo tee -a /etc/apt/sources.list.d/feelpp.list
    rm -f feelpp.gpg
    sudo apt -qq update
    sudo apt-get -y install python3-petsc4py
    sudo apt-get -y install  --no-install-recommends \
               python3-feelpp-toolboxes-coefficientformpdes \
       	       python3-feelpp-toolboxes-thermoelectric python3-feelpp-toolboxes-electric python3-feelpp-toolboxes-heat \
      	       python3-feelpp-toolboxes-fluid python3-feelpp-toolboxes-solid \
      	       python3-feelpp-toolboxes-hdg \
               python3-feelpp-mor
    sudo apt-get -y install --no-install-recommends feelpp-quickstart feelpp-tools libfeelpp-toolboxes1-fsi
fi

