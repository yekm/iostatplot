iostat -y -t -d /dev/sda -o JSON 1 | tee iostat.log
#iostat -x -y -t -d /dev/sda -o JSON 1 | tee iostatx.log
#vmstat -t -w 1 | tee vmstat.log
