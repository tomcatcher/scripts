#!/bin/bash

# This script installs speedtest-cli by Ookla (for Debian) and runs a speedtest.

# Check if speedtest is installed. If not, install it.
if [ -x "$(command -v speedtest)" ]; then
    echo "speedtest is already installed. Running test..."
else
    echo "speedtest is not installed. Installing..."
    sudo apt-get install curl
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
    sudo apt-get install speedtest
    echo "speedtest installed. Running test..."
fi

# Running the test

speedtest

# Done! Great and exit.
echo "Done!"
exit 0

# # Log script start (info)
# infomessage="Starting speedtest script"
# logmessage="INFO   $(echo \"$infomessage\")"
# echo "$logmessage" | systemd-cat -t "speedtest" -p "info"

# # Checking if server-side is ready
# # Log info (info)
# infomessage="Checking if server-side is ready"
# logmessage="INFO   $(echo \"$infomessage\")"
# echo "$logmessage" | systemd-cat -t "speedtest" -p "info"

# serverside=$(nmap signitron.com -oG - -p 5201 | grep "Ports" | awk '{ print $5 }' | awk -F/ '{ print $2 }')

# if [[ "$serverside" != "open" ]]
# then
#     # Log error (err)
#     errormessage="Server-side is not ready"
#     logmessage="ERROR  $(echo \"$errormessage\")"
#     echo "$logmessage" | systemd-cat -t "speedtest" -p "err"
#     exit 1
# fi

# if [[ "$serverside" == "open" ]]
# then
#     # Log info (info)
#     infomessage="Server-side is ready"
#     logmessage="INFO   $(echo \"$infomessage\")"
#     echo "$logmessage" | systemd-cat -t "speedtest" -p "info"
# fi

# # Log script waiting phase (info)
# infomessage="Waiting for random time (1-840s)"
# logmessage="INFO   $(echo \"$infomessage\")"
# echo "$logmessage" | systemd-cat -t "speedtest" -p "info"

# # Wait for random time (1-840s)
# sleep $[ ( $RANDOM % 840 )  + 1 ]s

# # Speedtest (upload) - 1s

# uploadresult=`iperf3 -c signitron.com -f m -P 3 -t 1 -i 0 2>&1 | grep SUM | awk '{ total += $6; count++ } END { print total/count }'`
# downloadresult=`iperf3 -c signitron.com -R -f m -P 3 -t 1 -i 0 2>&1 | grep SUM | awk '{ total += $6; count++ } END { print total/count }'`

# # Log info (info) - 1s
# infomessage="Speedtest (upload, 1s) result: $uploadresult Mbits/sec"
# logmessage="INFO   $(echo \"$infomessage\")"
# echo "$logmessage" | systemd-cat -t "speedtest" -p "info"

# # Log info (info) - 1s
# infomessage="Speedtest (download, 1s) result: $downloadresult Mbits/sec"
# logmessage="INFO   $(echo \"$infomessage\")"
# echo "$logmessage" | systemd-cat -t "speedtest" -p "info"

# # Speedtest (upload) - 3s

# # uploadresult=`iperf3 -c signitron.com -f m -P 3 -t 3 -i 0 2>&1 | grep SUM | awk '{ total += $6; count++ } END { print total/count }'`
# # downloadresult=`iperf3 -c signitron.com -R -f m -P 3 -t 3 -i 0 2>&1 | grep SUM | awk '{ total += $6; count++ } END { print total/count }'`

# # Log info (info) - 3s
# # infomessage="Speedtest (upload, 3s) result: $uploadresult Mbits/sec"
# # logmessage="INFO   $(echo \"$infomessage\")"
# # echo "$logmessage" | systemd-cat -t "speedtest" -p "info"

# # Log info (info) - 3s
# # infomessage="Speedtest (download, 3s) result: $downloadresult Mbits/sec"
# # logmessage="INFO   $(echo \"$infomessage\")"
# # echo "$logmessage" | systemd-cat -t "speedtest" -p "info"

# # Log script end (info)
# infomessage="Ending speedtest script"
# logmessage="INFO   $(echo \"$infomessage\")"
# echo "$logmessage" | systemd-cat -t "speedtest" -p "info"

# exit 0