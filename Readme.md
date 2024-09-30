# Diskos - Disk Utility Program for Linux

Diskos is a powerful and user-friendly disk utility program made for Linux, leveraging inbuilt tools like `smartctl`, `fdisk`, `dd`, and `badblocks`. It allows users to perform a variety of disk-related tasks easily through a menu-driven interface, making it accessible to both beginners and experienced users.

## Features

Diskos enables the following disk operations:
- **View Disk Status**: Check the current status of all mounted disks.
- **See Disk Information**: Retrieve detailed information about a specific disk.
- **See Disk Partition Information**: Display partition details of all disks.
- **Perform Bad Sector Check**: Run a bad block scan on any disk partition.
- **SMART Check**: Utilize SMART (Self-Monitoring, Analysis, and Reporting Technology) to assess the health of disks.
- **Benchmark**: Perform benchmarking to assess disk performance.

## Installation

Before running Diskos, ensure the required utilities are installed. You will need `smartctl`, `fdisk`, `dd`, and `badblocks` to fully utilize all of Diskos' features.

To install these tools, you can run:

```bash
sudo apt-get install smartmontools fdisk util-linux badblocks
```
## Usage

To run Diskos, follow these steps:

1. **Ensure root privileges**:
   Diskos requires administrative privileges to function correctly. Run the script as root using `sudo`.

   ```bash
   sudo ./diskos.sh
