#!/bin/bash

DEFAULT_INTERFACE=$(ip route get 8.8.8.8 | awk -- '{printf $5}')

echo "Applying ufw rules for Subtensor"
ufw allow in on lo to 127.0.0.0/24 port 9944 proto tcp
ufw deny in on $DEFAULT_INTERFACE to any port 9944 proto tcp
ufw allow in on $DEFAULT_INTERFACE to any port 9933 proto tcp
ufw allow in on $DEFAULT_INTERFACE to any port 30333 proto tcp

