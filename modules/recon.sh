#!/bin/bash
# recon.sh - Reconnaissance Phase

TARGET=$1
OUTPUT_DIR=$2

mkdir -p $OUTPUT_DIR

# Subdomain Enumeration
echo "[+] Running Subfinder..."
subfinder -d $TARGET -silent -o $OUTPUT_DIR/subfinder.txt

echo "[+] Running Assetfinder..."
assetfinder --subs-only $TARGET >> $OUTPUT_DIR/subfinder.txt

echo "[+] Running Amass..."
amass enum -passive -d $TARGET -o $OUTPUT_DIR/amass.txt

# Combine and clean subdomains
sort -u $OUTPUT_DIR/*.txt > $OUTPUT_DIR/all_subs.txt

# Probing for live hosts
echo "[+] Probing live hosts with httpx..."
httpx -l $OUTPUT_DIR/all_subs.txt -silent -o $OUTPUT_DIR/live_hosts.txt

# DNS Enumeration
echo "[+] Running DNSenum..."
dnsenum $TARGET > $OUTPUT_DIR/dnsenum.txt

# Whois Lookup
echo "[+] Performing WHOIS lookup..."
whois $TARGET > $OUTPUT_DIR/whois.txt

# Technology Fingerprinting
whatweb -i $OUTPUT_DIR/live_hosts.txt -o $OUTPUT_DIR/whatweb.txt --log-verbose
wappalyzer httpx -l $OUTPUT_DIR/live_hosts.txt -json > $OUTPUT_DIR/wappalyzer.json

--------------------------
