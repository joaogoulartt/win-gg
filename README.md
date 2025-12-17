# Windows on Docker

Project to run Windows in a Docker container using [dockurr/windows](https://github.com/dockurr/windows).

## 🚀 Requirements

- Docker and Docker Compose installed
- Linux system with KVM support (virtualization)
- Approximately 25GB of available disk space
- Minimum of 8GB of available RAM

## 📦 Project Structure

```
.
├── docker-compose.yaml    # Container configuration
├── setup.sh              # Setup script
├── windows/              # Windows persistent storage
└── shared/               # Shared folder between host and Windows
```

## ⚙️ Configuration

The container is configured with:

- **Windows Version**: 11
- **RAM**: 8GB
- **CPU Cores**: 4
- **Ports**:
  - `8006`: Web interface (noVNC)
  - `3389`: Remote Desktop Protocol (RDP)

### Changing Configuration

To modify RAM or CPU cores, edit the `docker-compose.yaml` file:

```yaml
environment:
  VERSION: "11"
  RAM_SIZE: "8G"      # Change RAM here (e.g., "4G", "16G")
  CPU_CORES: "4"      # Change CPU cores here (e.g., "2", "8")
```

### USB Passthrough (Optional)

To enable USB device passthrough, uncomment and configure in `docker-compose.yaml`:

```yaml
environment:
  ARGUMENTS: "-device usb-host,vendorid=0xXXXX,productid=0xXXXX"
devices:
  - /dev/bus/usb  # Enable USB passthrough
```

Use `lsusb` to find your device's vendor and product IDs.

After making changes, restart the container:

```bash
docker compose down
docker compose up -d
```

## 🛠️ Installation

Run the setup script:

```bash
./setup.sh
```

Or manually:

```bash
mkdir -p shared windows
docker compose up -d
```

## 🌐 Access

### Via Browser (noVNC)

Access: http://localhost:8006

### Via Remote Desktop

- **Host**: localhost
- **Port**: 3389
- Use an RDP client like `remmina`, `xfreerdp`, or Microsoft Remote Desktop

## 📁 File Sharing

The `shared/` folder is shared between the host and Windows. Files placed in this folder will be accessible on both systems.

## 🔧 Useful Commands

```bash
# Start the container
docker compose up -d

# View logs
docker compose logs -f

# Stop the container
docker compose down

# Restart the container
docker compose restart

# Remove completely (including data)
docker compose down -v
rm -rf windows/ shared/
```

## 📝 Notes

- The first boot may take some time to download and install Windows
- Windows data is persisted in the `windows/` folder
- The container uses `/dev/kvm` for hardware acceleration
- A 2-minute graceful shutdown period is recommended (`stop_grace_period: 2m`)
- Container is set to manual start (`restart: "no"`) - it won't auto-start on system boot

## ⚠️ Important Warnings

- **DO NOT** manually modify files inside the `windows/` folder - these are system files managed by the Windows VM
- Only the `shared/` folder should be used for file exchange between host and Windows
- Configuration changes (RAM, CPU, etc.) must be made in `docker-compose.yaml`, not directly in the container

## 🔗 Resources

- [dockurr/windows - GitHub](https://github.com/dockurr/windows)
- [Official Docker Documentation](https://docs.docker.com/)
