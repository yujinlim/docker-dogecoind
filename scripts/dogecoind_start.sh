#!/bin/bash

# if there is no args passed, try to check if there is any dogecoin.conf
if [ $# -eq 0 ]; then
	if [ ! -e "$HOME/.dogecoin/dogecoin.conf" ]; then
		mkdir -p $HOME/.dogecoin

		echo "Creating dogecoin.conf"

		# Seed a random password for JSON RPC server
		cat <<EOF > $HOME/.dogecoin/dogecoin.conf
disablewallet=1
printtoconsole=1
rpcuser=${RPCUSER:-dogecoinrpc}
rpcpassword=${RPCPASSWORD:-`dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64`}
EOF

	fi

	cat $HOME/.dogecoin/dogecoin.conf
fi

dogecoind "$@"
