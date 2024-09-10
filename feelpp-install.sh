#!/bin/bash
set +x

echo $(whoami)

# install feelpp stuff
if [ ! -f /etc/apt/sources.list.d/feelpp.list ]; then
    echo "Installing feelpp packages"
    DIST=$(lsb_release -cs)
    sudo apt-get install wget gpg
    sudo wget -qO - http://apt.feelpp.org/apt.gpg | sudo apt-key add -
    echo "deb http://apt.feelpp.org/debian/$DIST $DIST latest" | sudo tee -a /etc/apt/sources.list.d/feelpp.list
    rm -f feelpp.gpg
    sudo apt -qq update
    sudo apt-get -y install  --no-install-recommends \
               python3-feelpp-toolboxes-coefficientformpdes \
       	       python3-feelpp-toolboxes-thermoelectric python3-feelpp-toolboxes-electric python3-feelpp-toolboxes-heat \
      	       python3-feelpp-toolboxes-fluid python3-feelpp-toolboxes-solid \
      	       python3-feelpp-toolboxes-hdg; \
fi

