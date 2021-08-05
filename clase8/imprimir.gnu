set terminal eps transparent size 6,4 lw 1.8 enhanced font "Times,24"
set encoding iso_8859_1
set title 'circulo'
set output "imprimir.eps"
set grid
set xrange[0:5]
set yrange[0:10]
plot 'fourier.dat' w l
