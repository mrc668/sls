#!/bin/bash
# source salt:/sls/salt/sdlSalt.sh

grep "Springdale Open Enterprise" /usr/lib/python3.6/site-packages/salt/grains/core.py -q || {
  sed -e '/^_OS_FAMILY_MAP/a "Springdale Open Enterprise": "RedHat",' -i /usr/lib/python3.6/site-packages/salt/grains/core.py
}

