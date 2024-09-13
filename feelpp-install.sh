#!/bin/bash
set +x

sudo apt -y install core-utils
echo $(whoami)

sudo apt -y install clsb-release
platform=$(lsb_release -ds | cut -d " " -f 1 | tr '[:upper:]' '[:lower:]')
echo "Install for platform=${platform}"

# install feelpp stuff
if [ ! -f /etc/apt/sources.list.d/feelpp.list ]; then
    echo "Installing feelpp packages"
    sudo apt-get -y install lsb-release
    DIST=$(lsb_release -cs)
    sudo apt-get -y install wget gpg
    sudo wget -qO - http://apt.feelpp.org/apt.gpg | sudo apt-key add -
    echo "deb http://apt.feelpp.org/${platform}/$DIST $DIST latest" | sudo tee -a /etc/apt/sources.list.d/feelpp.list
    rm -f feelpp.gpg
    sudo apt -qq update
    sudo apt-get -y install  --no-install-recommends \
               python3-feelpp-toolboxes-coefficientformpdes \
       	       python3-feelpp-toolboxes-thermoelectric python3-feelpp-toolboxes-electric python3-feelpp-toolboxes-heat \
      	       python3-feelpp-toolboxes-fluid python3-feelpp-toolboxes-solid \
      	       python3-feelpp-toolboxes-hdg; \
fi

