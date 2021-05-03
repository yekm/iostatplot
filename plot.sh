#!/bin/bash
set -e

f=iostat.log

( cat $f ; echo ']}]}}') | jq '.sysstat.hosts[0].statistics[] | .timestamp' >t
( cat $f ; echo ']}]}}') | jq '.sysstat.hosts[0].statistics[] | .disk[0].kB_read' >r
( cat $f ; echo ']}]}}') | jq '.sysstat.hosts[0].statistics[] | .disk[0].kB_wrtn' >w
#( cat $f ; echo ']}]}}') | tr '/' '_' | jq '.sysstat.hosts[0].statistics[] | .disk[0].kB_read_s' | tail -n +2 >rs
#( cat $f ; echo ']}]}}') | tr '/' '_' | jq '.sysstat.hosts[0].statistics[] | .disk[0].kB_wrtn_s' | tail -n +2 >ws
tr=$(cat r | egrep -v '^0$' | paste -sd + | bc)
tw=$(cat w | egrep -v '^0$' | paste -sd + | bc)
echo "total read  " $(bc <<< "$tr/1024") " MiB"
echo "total write " $(bc <<< "$tw/1024") " MiB"
paste -d "\t" t r >tr
paste -d "\t" t w >tw
gnuplot a.gnuplot
#sxiv stat.png

