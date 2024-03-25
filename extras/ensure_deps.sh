#!/bin/bash

ensure_dependencies() {
  local missing_deps=()
  for dep in "$@"; do
    if ! command -v "$dep" &> /dev/null; then
      missing_deps+=("$dep")
    fi
  done
  if [ ${#missing_deps[@]} -ne 0 ]; then
    echo "The following dependencies are missing: ${missing_deps[*]}"
    echo "Attempting to install missing dependencies..."
    sudo apt-get update
    sudo apt-get install -y "${missing_deps[@]}"
  else
    echo "All dependencies are met."
    return 0
  fi
}

ensure_bindeps() {
  local missing_bins=()
  for bin in "$@"; do
    if ! command -v "$bin" &> /dev/null; then
      missing_bins+=("$bin")
    fi
  done
  if [ ${#missing_bins[@]} -ne 0 ]; then
    echo "The following debindencies are missing: ${missing_bins[*]}"
    return 1
  else
    echo "All debindencies are met."
    return 0
  fi
}