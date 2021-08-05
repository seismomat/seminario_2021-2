set terminal eps transparent size 6,4 lw 1.8 enhanced font "Times,24"
set encoding iso_8859_1
set title 'Senal'
set output "imprimir1.eps"
set grid
set xrange[0:5]
set yrange[-3:3]
plot 'signal.dat' w l
