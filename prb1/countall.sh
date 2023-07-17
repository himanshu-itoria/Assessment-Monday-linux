#!/bin/bash

log_file="../prb1/web-server (5).log"  
declare -A http_codes_counts

while IFS= read -r line; do
    
    status_code=$(echo "$line" | awk '{print $9}')

    
    ((http_codes_counts[$status_code]++))
done < "$log_file"


echo "HTTP Response Codes and Their Counts:"
for code in "${!http_codes_counts[@]}"; do
    echo "HTTP $code: ${http_codes_counts[$code]} occurrences"
done

