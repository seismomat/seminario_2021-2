#include <stdio.h>
#include <omp.h>
#include <stdlib.h>

#include "modulo.h"

int main(){

	int N; // tamanio de la matriz 
	double **A; double **B; double **C;

	double start_time, run_time;

	printf(" Ingrese la dimension \n");
	scanf(" %d",&N);

	A=malloc_fill(A,N);
	B=malloc_fill(B,N);
	C=malloc_zeros(C,N);

	start_time = omp_get_wtime();

	printf(" %lf",A[0][0]);
	printf(" %lf",B[0][0]);
	printf(" %lf",C[0][0]);

	C=seq_matmul(N,N,N,A,B,C);

	run_time = omp_get_wtime() - start_time;

	printf("\n Execution time was %lf seconds\n ",run_time);


	return 0;
}