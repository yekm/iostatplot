set terminal pngcairo size 1920,1080 enhanced font 'Verdana,10'
#set yrange [0:]
set style fill  transparent solid 0.35 noborder
#set output 'persecond.png'
#plot 'rs' using 1 with points pt 7 ps 0.2, \
#     'ws' using 1 with points pt 7 ps 0.2
#set output 'total.png'
#plot 'r' using 1 with points pt 7 ps 0.2, \
#     'w' using 1 with points pt 7 ps 0.2

set output 'stat.png'
# average over N values
N = 300
array Avg[N]
array X[N]

MovAvg(col) = (Avg[(t-1)%N+1]=column(col), n = t<N ? t : N, t=t+1, (sum [i=1:n] Avg[i])/n)
MovAvgCenterX(col) = (X[(t-1)%N+1]=column(col), n = t<N ? t%2 ? NaN : (t+1)/2 : ((t+1)-N/2)%N+1, n==n ? X[n] : NaN)   # be aware: gnuplot does integer division here

set datafile missing NaN
set xdata time
set timefmt '"%d/%m/%y %H:%M:%S"'
set format x "%H:%M"

plot 'tw' u 1:2 w p pt 7 ps 0.2 ti "kB", \
    t=1 '' u 1:(MovAvg(2)) w l lc rgb "red" ti sprintf("Write mov avg over %d",N), \
    'tr' using 1:2 with points pt 7 ps 0.2, \
    t=1 '' u 1:(MovAvg(2)) w l lc rgb "green" ti sprintf("Read mov avg over %d",N)

