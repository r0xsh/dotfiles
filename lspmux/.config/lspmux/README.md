# lspmux Installation

lspmux is a Language Server Protocol multiplexer that allows multiple LSP servers to run simultaneously.

## Prerequisites
- Rust toolchain (cargo)
- systemd (for service management)

## Installation

```bash
# Clone the repository
git clone https://codeberg.org/p2502/lspmux/
cd lspmux

# Apply the initialization patch (fixes LSP server notifications)
git apply /path/to/lspmux-init.patch

# Build the release binary
cargo build --release

# Install globally
sudo cp target/release/lspmux /usr/bin/

# Set up systemd service
cp lspmux.service ~/.config/systemd/user/
systemctl enable --now --user lspmux.service
```

The patch handles early LSP server notifications during initialization, preventing connection issues with language servers that send messages before the initialization handshake completes.