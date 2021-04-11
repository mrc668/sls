#!/bin/bash
# source salt:/sls/salt/sdlSalt.sh

grep "Springdale Open Enterprise" /usr/lib/python3.6/site-packages/salt/grains/core.py -q || {
  patch -p0 /usr/local/src/salt.p1
}

