#!/bin/bash

# the image will be removed when stopped
docker run --rm -it -v `pwd`:/host isa-devops/dd-client-office

# ^C to stop
