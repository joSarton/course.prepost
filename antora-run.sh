#!/bin/bash
#

# date >> start.log
if [ ! -f start.log ]; then
    touch start.log
fi

npx antora --cache-dir=public/.cache/antora site-dev.yml >> start.log 2>&1 
