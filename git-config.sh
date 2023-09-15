#!/bin/bash
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Fri Sep 15 03:01:13 PM UTC 2023
#

set -e
set -x

cd "$(dirname "$0")"
git config user.name sfmunoz
git config user.email 46285520+sfmunoz@users.noreply.github.com
cat .git/config
git log --format=fuller -n 3
