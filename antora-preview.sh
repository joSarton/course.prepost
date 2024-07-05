#!/bin/bash
set +x

usage() {
    echo ""
    echo "Antora Documentation Previewer"
    echo ""
    echo "This command builds an Antora documentation website locally and launches a web server on port 2020 to browse the documentation."
    echo ""
    echo "Arguments:"
    echo ""
    echo "    -d=PATH / --dir=PATH:"
    echo "           Path to the antora docs basedir."
    echo "           Default: '/preview'"
    echo ""
    echo "    --style=STYLE / -s=STYLE:"
    echo "           Antora UI Bundle to use to render the documentation."
    echo "           Valid values: 'feelpp', 'vshn', 'appuio', 'syn', 'k8up', 'antora'."
    echo "           Default value: 'feelpp'"
    echo ""
    echo "    -a=PATH / --antora=PATH:"
    echo "           Path to the subfolder."
    echo "           Default: 'docs'"
    echo ""
    echo "Examples:"
    echo "    antora-preview --dir=/preview --style=appuio --antora=src"
    echo ""
    echo "GitHub project: https://github.com/vshn/antora-preview"
    echo ""
    exit 0
}

# A wrapper to run subprocesses in the background but forward SIGTERM/SIGINT to them
# Adapted from https://medium.com/@manish_demblani/docker-container-uncaught-kill-signal-d5ed22698293
signalListener() {
    "$@" &
    pid="$!"
    trap "caddy stop; echo 'Stopping PID $pid'; kill -SIGTERM $pid" SIGINT SIGTERM

    # A signal emitted while waiting will make the wait command return code > 128
    # Let's wrap it in a loop that doesn't end before the process is indeed stopped
    while kill -0 $pid > /dev/null 2>&1; do
	# Only wait for the specific child pid we extracted in this function,
	# as otherwise we wait forever for the ruby subprocess started by
	# `guard` which is apparently not properly terminated when sending
	# `SIGTERM` to `guard`.
        wait $pid
    done
}

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

