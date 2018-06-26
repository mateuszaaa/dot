#!/bin/bash
REPO_ROOT=$(readlink -f $1)
echo "ROOT: $REPO_ROOT"

if [ -z $REPO_ROOT ]; then
  echo project root not specified
  exit -1
fi

if [ ! -e $REPO_ROOT ]; then
  echo $REPO_ROOT does not exists
  exit -1
fi
rm -rf $REPO_ROOT/bin/docker/userconfig/vim 2>/dev/null
rm -rf $REPO_ROOT/bin/docker/userconfig/install.sh 2>/dev/null
cp -r ~/config/vim $REPO_ROOT/bin/docker/userconfig/
cp -r ~/config/install.sh $REPO_ROOT/bin/docker/userconfig/
cd $REPO_ROOT
./bin/exec.bash /config/install.sh
