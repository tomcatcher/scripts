#!/bin/bash

# Set the path to the CSV file
CSV_FILE="/root/passwds.csv"

# Read the CSV file line by line
while IFS=',' read -r name url username password; do
    # If url begins with http:// or https://, encode url to base64
    if [[ "$url" == "http://"* ]] || [[ "$url" == "https://"* ]]
    then
        url=$(echo "$url" | base64)
    fi
    # If url begins with android://, leave url as is
    if [[ "$url" == "android://"* ]]
    then
        url="$url"
    fi

    # Insert the password into pass
    # echo "$name $url $username $password"
    echo -e "$password\n$password" | /usr/bin/pass insert -e import-from-edge/$name/$url/$username
done < "$CSV_FILE"

# Exit with status code 0
exit 0
