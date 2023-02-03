#! /bin/bash

KVMDINFO=$(cat /usr/local/lib/python3.10/kvmd-packages/kvmd*egg-info/PKG-INFO)
CURRENTWD=$PWD
PATCHWD=$PWD/patches/
if [[ -z "$KVMDINFO" ]]; then
  echo "looks like KVMD is not installed or installed in another path exiting"
  exit
fi
ver=$(echo $KVMDINFO | sed 's/.*Version\s*:\s*\(.*\)\s*Summary.*/\1/' | sed -e 's/[[:space:]]*$//')
PATCHFILE=$PATCHWD$ver"msd.patch"

if [ ! -e "$PATCHFILE" ]; then 
  echo "looks like there is no patch for version $ver"
fi

echo "everything looks good, patching KVMD for OTG MSD function"
cd /usr/local/lib/python3.10/kvmd-packages/
patch -s -p0 < $PATCHFILE

echo "KVMD is patched"
cd "CURRENTWD"
exit
