#!/bin/bash
# scanning.sh - Vulnerability Scanning Phase

TARGET=$1
OUTPUT_DIR=$2

mkdir -p $OUTPUT_DIR

# Directory Bruteforce
echo "[+] Running Dirsearch..."
dirsearch -l $OUTPUT_DIR/live_hosts.txt -e php,html,js -o $OUTPUT_DIR/dirsearch.txt

# SSL Scanning
echo "[+] Running SSLScan..."
sslscan $TARGET > $OUTPUT_DIR/sslscan.txt

# Nikto Web Scan
echo "[+] Running Nikto..."
nikto -h $TARGET -output $OUTPUT_DIR/nikto.txt

# Port Scan with Nmap
echo "[+] Running Nmap..."
nmap -sV -T4 -p- $TARGET -oN $OUTPUT_DIR/nmap.txt

# Nuclei Scan
echo "[+] Running Nuclei (OWASP + CVEs)..."
nuclei -l $OUTPUT_DIR/live_hosts.txt -t "cves/,vulnerabilities/,misconfiguration/,exposures/" -o $OUTPUT_DIR/nuclei.txt

--------------------------
