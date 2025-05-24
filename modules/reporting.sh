#!/bin/bash
# reporting.sh - Reporting Phase

TARGET=$1
OUTPUT_DIR=$2
REPORT_FILE=$OUTPUT_DIR/report.txt

mkdir -p $OUTPUT_DIR

# Combine all results
echo "Bug Bounty Report for $TARGET" > $REPORT_FILE
echo "====================================" >> $REPORT_FILE

echo -e "\n[+] Subdomains:" >> $REPORT_FILE
cat $OUTPUT_DIR/all_subs.txt >> $REPORT_FILE

echo -e "\n[+] Live Hosts:" >> $REPORT_FILE
cat $OUTPUT_DIR/live_hosts.txt >> $REPORT_FILE

echo -e "\n[+] Nmap Ports:" >> $REPORT_FILE
cat $OUTPUT_DIR/nmap.txt >> $REPORT_FILE

echo -e "\n[+] Vulnerabilities Found (Nuclei):" >> $REPORT_FILE
cat $OUTPUT_DIR/nuclei.txt >> $REPORT_FILE

echo -e "\n[+] XSS Issues (Dalfox):" >> $REPORT_FILE
cat $OUTPUT_DIR/dalfox.txt >> $REPORT_FILE

echo -e "\n[+] SQL Injection (SQLMap):" >> $REPORT_FILE
cat $OUTPUT_DIR/sqlmap/*/log >> $REPORT_FILE 2>/dev/null

# Timestamp
echo -e "\nReport Generated on: $(date)" >> $REPORT_FILE

echo "[+] Final report available at $REPORT_FILE"
