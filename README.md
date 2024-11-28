# PortSeeker

This is an advanced port scanner written in **Bash** that allows you to scan a target host for open or closed ports. You can scan a specific port, a range of ports, and specify various parameters like timeout and threads for parallel scanning. It is designed to be fast and flexible for various use cases.

## Features
- **Single Port Scan**: Scan a specific port, e.g., `80`.
- **Range Scan**: Scan a range of ports, e.g., `80-3000`.
- **Parallel Scanning**: Use multiple threads to speed up the scanning process.
- **Custom Timeout**: Adjust the timeout for each port scan.

## Requirements
- **Bash**: The script is written for a Linux environment and requires Bash.
- **Netcat (`nc`)**: Used to check if ports are open.
- **Ping**: Used to verify if the target is reachable.

## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/0xAminED/PortSeeker.git
    cd PortSeeker
    ```

2. **Make the script executable**:
    ```bash
    chmod +x PortSeeker.sh
    ```

3. **Run the script**:
    ```bash
    ./PortSeeker.sh -t <target_host> -p <ports> -T <timeout_seconds> -p <threads>
    ```

    Example:
    ```bash
    ./PortSeeker.sh -t 192.168.1.1 -p 80 -T 2 -p 10
    ```

    - `-t <target_host>`: The target IP address or domain name.
    - `-p <ports>`: A single port (e.g., `80`) or a port range (e.g., `80-3000`).
    - `-T <timeout_seconds>`: Timeout in seconds for each port scan (default: 1 second).
    - `-p <threads>`: The number of threads for parallel scanning (default: 50).

## Example Usage

1. **Scan a single port**:
    ```bash
    ./PortSeeker.sh -t 192.168.1.1 -p 80 -T 2 -p 10
    ```

2. **Scan a range of ports**:
    ```bash
    ./PortSeeker.sh -t 192.168.1.1 -p 80-1000 -T 1 -p 20
    ```

3. **Scan a specific range with a custom timeout and thread count**:
    ```bash
    ./PortSeeker.sh -t 192.168.1.1 -p 8000-8100 -T 3 -p 30
    ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the contributors for their valuable feedback and improvements.
