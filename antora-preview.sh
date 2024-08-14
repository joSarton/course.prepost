#!/bin/bash
set +x

# install feelpp stuff
sudo apt-get install wget gpg
wget -qO - http://apt.feelpp.org/apt.gpg | sudo apt-key add -
echo "deb http://apt.feelpp.org/debian/bookworm bookworm latest" | sudo tee -a /etc/apt/sources.list.d/feelpp.list
rm -f feelpp.gpg
sudo apt -qq update
# sudo apt install -y

# install python stuff
sudo apt install -y python-is-python3 python3-venv 
python3 -m venv --system-site-packages .venv
source .venv/bin/activate
pip3 install -r requirements.txt

# install utilities tools
sudo apt install -y pandoc

# install firefox for LiveServer
sudo apt install -y firefox-esr

# Get and Install Livereload extension


# install
# sudo chown -R vscode:vscode . # in wsl remote container
npm install

# Generate website
npx antora --cache-dir=public/.cache/antora site-dev.yml

# Launch Guard for files
echo ""
echo " ___________________________________________________________________________"
echo "|                                                                           |"
echo "| Use VScode LiveServer to view the doc                                     |"
echo "| Click on the icon at the bottom right of VSc windows to start the server  |"
echo "|___________________________________________________________________________|"
echo ""
# sudo caddy start
# signalListener .. # from antora-preview but this seems buggy
guard -p --no-interactions -w docs public
# watchmedo auto-restart -d ./docs/ -p '*.adoc' --recursive `./antora-run.sh`
