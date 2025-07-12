# MikroTik Office Network Infrastructure

This project simulates a small office network using MikroTik CHR (Cloud Hosted Router), implementing VLAN segmentation, DHCP, DNS, NAT, and basic firewall rules with bandwidth management. Designed to be reproducible on VirtualBox and suitable for learning or real-world deployment.

---

## Project Objectives

- Implement VLAN-based segmentation for 3 departments: Management, Staff, and Guests
- Configure DHCP, DNS, and NAT on MikroTik RouterOS
- Apply basic firewall rules and bandwidth shaping
- Enable system monitoring via built-in MikroTik tools
- Provide complete reproducible documentation

---

## Network Topology

![Small Office Topology](https://github.com/user-attachments/assets/47bbd344-b9cc-439a-885c-2465b3adbcfb)

---

## IP Address Planning

| VLAN | Department  | Network        | Gateway        | DHCP Range              |
|------|-------------|----------------|----------------|--------------------------|
| 10   | Management  | 192.168.10.0/24 | 192.168.10.1   | 192.168.10.50–100        |
| 20   | Staff       | 192.168.20.0/24 | 192.168.20.1   | 192.168.20.50–150        |
| 30   | Guest       | 192.168.30.0/24 | 192.168.30.1   | 192.168.30.50–200        |

---

## Firewall & Bandwidth Policy

- **Management**: Full access
- **Staff**: Internet & File Server only (10 Mbps per user)
- **Guest**: Internet only (2 Mbps/user, max 10 Mbps)

---

## Monitoring Tools

- **Torch**: Real-time monitoring
- **Graphing**: Usage stats
- **Logs**: Security alerts
- **Backup**: Scheduled config backup

---

## How to Run This Project

1. Install [VirtualBox 6.1+](https://www.virtualbox.org/)
2. Import the MikroTik CHR image
3. Download file `Small Office Setup`
4. Load the config from `Small Office Setup.rsc` via Winbox or terminal

---

## 📎 Documentation

- `Implementasi Network Infrastructure dengan Mikrotik RouterOS.pdf`: Full project explanation

---

## Author

Created by [Viqram Ananta Wataf], IT Network and Cybersecurity.  
Reach out via [[LinkedIn]](https://www.linkedin.com/in/viqramwataf/).
