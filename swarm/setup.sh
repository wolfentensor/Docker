#!/bin/bash
#
# Run Subtensor (Substrate) under gVisor
# Only supports Docker standalone mode for now.
#
source ../extras/ensure_deps.sh


install_runsc() {
  wget https://storage.googleapis.com/gvisor/releases/release/latest/x86_64/runsc
  sudo mv runsc /usr/local/bin
  sudo chmod +x /usr/local/bin/runsc
}

ensure_dependencies wget docker sudo
ensure_bindeps runsc || { [ $? -eq 1 ] && install_runsc }

mv /etc/docker/daemon.json /etc/docker/daemon.backup
cat >/etc/docker/daemon.json <<EOL
{
  "runtimes": {
    "runsc": {
      "path": "runsc",
      "runtimeArgs": []
    },
    "runc": {
      "path": "runc",
      "runtimeArgs": []
    }
  },
  "default-runtime": "runsc"
}
EOL

systemctl restart docker






