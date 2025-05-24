#!/bin/bash

# DARKHUNTER - Bug Bounty Automation Framework
# Author: YourNameHere
# GitHub: https://github.com/YourUsername/DarkHunter

# ==============================
#   ____             _    _           _             
#  |  _ \  __ _ _ __| | _(_)_ __   __| | ___ _ __   
#  | | | |/ _` | '__| |/ / | '_ \ / _` |/ _ \ '__|  
#  | |_| | (_| | |  |   <| | | | | (_| |  __/ |     
#  |____/ \__,_|_|  |_|\_\_|_| |_|\__,_|\___|_|     
#                                                  
#     DARKHUNTER - Automated Bug Bounty Framework
# ==============================

# Load configuration
source config.sh

# Create necessary output directories
mkdir -p "$OUTPUT_DIR"/{recon,scans,exploits,reports}

# Reconnaissance Phase
echo -e "\n[*] Starting Reconnaissance..."
bash modules/recon.sh "$TARGET" "$OUTPUT_DIR/recon"

# Vulnerability Scanning Phase
echo -e "\n[*] Starting Vulnerability Scanning..."
bash modules/scanning.sh "$TARGET" "$OUTPUT_DIR/scans"

# Exploitation Phase
echo -e "\n[*] Starting Exploitation..."
bash modules/exploitation.sh "$TARGET" "$OUTPUT_DIR/exploits"

# Reporting Phase
echo -e "\n[*] Generating Report..."
bash modules/reporting.sh "$TARGET" "$OUTPUT_DIR"

echo -e "\n[✓] DarkHunter Bug Bounty Automation Completed Successfully."
