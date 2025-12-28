# System Resource Sentinel 🛡️

A professional Bash-based monitoring utility designed for Linux environments (tested on Linux Mint). This script monitors critical system resources in the background, providing real-time desktop notifications and persistent logging when usage thresholds are exceeded.

## 🚀 Key Features
- **Automated Monitoring:** Real-time tracking of RAM, CPU, and Disk utilization.
- **Smart Alerting:** Integrated with `notify-send` for immediate GUI alerts.
- **Persistent Logging:** Maintains a detailed `system_log.txt` with formatted timestamps.
- **Cron Optimized:** Specifically configured with `DBUS` and `DISPLAY` variables to run reliably as a background service.
- **Precision Data:** Utilizes `awk` for calculating and rounding usage percentages from system binaries (`top`, `free`, `df`).

## 🛠️ Technical Implementation
This project demonstrates several advanced scripting concepts:
- **Modular Programming:** Logical separation of concerns into `alert()`, `logging()`, and `check_resources()` functions.
- **Environment Bridging:** Solves the common "Cron Notification" issue by exporting the user's Session Bus address.
- **Absolute Pathing:** Ensures the script runs correctly regardless of the directory from which it is executed.


## 🔧 Installation & Setup

- **Clone the repository:**
```
git clone [https://github.com/your-username/system-resource-sentinel.git](https://github.com/your-username/system-resource-sentinel.git)
cd system-resource-sentinel
```
- **Make the script executable:**
```
chmod +x sentinel.sh
```
- **Configure Automation (Cron): Open your crontab editor:**
```
crontab -e
```
## 📊 Log Format
```
The system_log.txt follows this structure: RAM CPU DISK DATE 
                                            85 12 15 28/12/25 14:45:01
```
