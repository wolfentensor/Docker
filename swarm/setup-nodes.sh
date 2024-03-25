#!/bin/bash

# Define the target directory on the remote system
TARGET_DIR="/tmp/subtensec"

# Function to copy current directory and execute a script on a remote node
setup_node() {
  local node=$1
  echo "Processing node: $node"

  # Create the target directory on the remote node
  ssh root@"$node" "mkdir -p $TARGET_DIR" 2>/dev/null

  # Copy the current directory to the target directory on the remote node
  scp -r ../* root@"$node":"$TARGET_DIR" 2>/dev/null

  # Execute the script on the remote node
  ssh root@"$node" "bash $TARGET_DIR/swarm/setup.sh"
  #2>/dev/null

  # Check if the script executed successfully
  if [ $? -eq 0 ]; then
    echo "Success: The script executed successfully on node $node"
    return 0
  else
    echo "Fail: The script execution failed on node $node"
    return 1
  fi
}

# Check if nodes.txt exists
if [ ! -f nodes.txt ]; then
  echo "Error: nodes.txt does not exist in the current working directory."
  exit 1
fi

# Read each line in nodes.txt and process it
while IFS= read -r node; do
  setup_node "$node"
done < nodes.txt