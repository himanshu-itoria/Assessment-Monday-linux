log_file="../prb1/web-server (5).log"  
http_200=0

while IFS= read -r line; do
    
    status_code=$(echo "$line" | awk '{print $9}')

    
    if [ "$status_code" = "200" ]; then
        ((http_200_count++))
    fi
done < "$log_file"

echo "Number of HTTP 200 errors: $http_200_count"
