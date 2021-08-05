#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

int prime_number(int n){
	
	int i,j; // indices
	int prime;
	int total=0;

	#pragma omp parallel shared(n) private(i ,j, prime)

	{

	//printf(" numero de hilos utilizados = %d \n",omp_get_num_threads());

	#pragma omp for reduction (+: total)


	for (i=2; i<=n;i++){

		prime=1;

		for(j=2; j<i; j++){

			if ( i % j ==0){

				prime=0;
				break;
			}
		}

		total = total + prime;
	}

    }
	return total;
}
int main(){
	
	int n_lo, n_hi, n_factor; 
	int n;
	int primes;

	n_lo=1;
	n_hi=10000;
	n_factor=2;

	printf(" Numero de procesadores disponibles = %d \n", omp_get_num_procs() );
	printf(" Numero de hilos= %d \n", omp_get_max_threads() );

	omp_set_num_threads(8);

	
	

	n=n_lo;

	while(n<=n_hi){
		double wtime= omp_get_wtime();

		primes=prime_number(n);

		wtime=omp_get_wtime() -wtime;

		printf(" Numero \t Primos\t  Tiempo\t \n");
		printf(" %8d %8d %14lf \n", n , primes,wtime);

		n= n*n_factor;

	}


	return 0;
}