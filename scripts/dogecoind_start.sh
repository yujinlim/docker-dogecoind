#!/bin/bash

set -x

if [ "$(id -u)" = '0' ]; then
	chown -R dogecoin .
	exec gosu dogecoin "$0" "$@"
fi

exec setup "$@"
