#!/bin/bash
set -ueo pipefail

VER='1.9.5'
EXTRA_OPTS=''

# changing default UID to current user
EXTRA_OPTS="${EXTRA_OPTS} --build-arg userid=$(id -u)"

if [ $# -ge 1 ]; then
	VER="$1"
	EXTRA_OPTS="${EXTRA_OPTS} --build-arg vagrant_version=${VER}"
fi

docker build -t "vagrant:${VER}" --rm $EXTRA_OPTS .
