
# Bittensor Subtensor with gVisor Security Enhancement

This repository is dedicated to running Bittensor's Subtensor node with an additional layer of security provided by gVisor. It is designed for experienced users who prioritize security in their setup. The integration of gVisor adds a robust security mechanism by sandboxing the Subtensor (Substrate) runtime environment, significantly reducing the risk surface compared to traditional container runtimes.

For more information, pleaes refer to the [gVisor Documentation](https://gvisor.dev/docs/).

## Prerequisites

This setup is intended for users who are familiar with Docker, gVisor, and the command line. A basic understanding of blockchain technology and containerization is recommended.

## Setup Instructions

### Step 1: Clone the Repository

Ensure you have this repository cloned to your local machine. All commands should be run from the root directory of this repository.

### Step 2: Run `setup.sh`

The `setup.sh` script prepares your environment for running Subtensor with gVisor. It performs the following actions:

- Checks for and installs basic dependencies.
- Installs gVisor (runsc).
- Backs up the current `/etc/docker/daemon.json` to `/etc/docker/daemon.backup`.
- Creates a new `daemon.json` with the gVisor configuration.
- Restarts the docker daemon.

Execute the script by running:

```bash
./setup.sh
```

### Step 3: Docker Compose Configuration

The `docker-compose.yml` in the current working directory (CWD) has been modified to pass a runtime argument, enabling gVisor (`runsc`) as the runtime for Subtensor. Ensure Docker Compose is correctly configured to use this setup.

### Step 4: Running Subtensor

To start Subtensor, you can use the modified `subtensor.sh` script located in the CWD. The script supports both secure and insecure modes:

- **Secure Mode** (With gVisor): Launches Subtensor in a sandboxed environment for enhanced security. Use the `--secure` flag:
  
  ```bash
  ./subtensor.sh --secure
  ```

- **Insecure Mode** (Without gVisor): Runs Subtensor without additional sandboxing. Use the `--insecure` flag for testing or development purposes where enhanced security is not a concern:
  
  ```bash
  ./subtensor.sh --insecure
  ```

## Monitoring and Testing

It is crucial to monitor the performance and behavior of Subtensor when running under gVisor due to the additional abstraction layer. Test your setup thoroughly to ensure compatibility and performance meet your requirements.

## Contributing

Contributions are welcome! Whether it's a feature enhancement, bug fixes, or security improvements, feel free to fork the repository and submit a pull request.

## Security

The integration of gVisor significantly enhances the security posture of the Subtensor node by isolating it from the host system. However, always keep your system updated and monitor for any vulnerabilities reported in both Subtensor and gVisor.

## License

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>

---------------------------
gVisor is Copyright (C) Google, LLC

Substrate is Copyright (C) Parity Technologies (UK) Ltd.


```
