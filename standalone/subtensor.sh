#!/usr/bin/env bash

#
# Script for running Subtensor
# with gVisor (or not)
#

# Default values
EXEC_TYPE="secure"
NETWORK="mainnet"
NODE_TYPE="lite"
RUNTIME="runsc"
BUILD=""

# Getting arguments from user
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      help
      exit 0
      ;;
    -s|--secure)
      EXEC_TYPE="secure"
      shift # past argument
      ;;
    -i|--insecure)
      EXEC_TYPE="insecure"
      shift # past argument
      ;;
    -b|--build)
      BUILD="--build"
      shift # past argument
      ;;
    -n|--network)
      NETWORK="$2"
      shift
      shift
      ;;
    -t|--node-type)
      NODE_TYPE="$2"
      shift
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1")
      shift
      ;;
  esac
done

# Verifying arguments values
if ! [[ "$EXEC_TYPE" =~ ^(secure|insecure)$ ]]; then
    echo "Exec type not expected: $EXEC_TYPE"
    exit 1
fi

if ! [[ "$NETWORK" =~ ^(mainnet|testnet)$ ]]; then
    echo "Network not expected: $NETWORK"
    exit 1
fi

if ! [[ "$NODE_TYPE" =~ ^(lite|archive)$ ]]; then
    echo "Node type not expected: $NODE_TYPE"
    exit 1
fi

# Running subtensor
case $EXEC_TYPE in
    insecure)
        docker compose down --remove-orphans
        echo "Starting Subtensor without gVisor (insecure mode)"
        export RUNTIME="runc"
        echo "Running docker compose up $BUILD --detach $NETWORK-$NODE_TYPE"
        docker compose up $BUILD --detach $NETWORK-$NODE_TYPE
    ;;
    secure)
        docker compose down --remove-orphans
        echo "Starting Subtensor with gVisor (secure mode)"
        export RUNTIME="runsc"
        echo "Running docker compose up $BUILD --detach $NETWORK-$NODE_TYPE"
        docker compose up $BUILD --detach $NETWORK-$NODE_TYPE
    ;;
esac