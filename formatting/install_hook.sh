#!/bin/bash
REPO_ROOT="$(dirname $(readlink -f $0))/.."
cp $REPO_ROOT/formatting/git-hook .git/hooks/pre-commit  
echo "hook reinstalled"
