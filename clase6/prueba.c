#include <stdio.h>
#include <omp.h>


int main(){
	
	omp_set_num_threads(2);

	#pragma omp parallel
	{
		
		 #pragma omp single
		{

			printf(" un \n");

			#pragma omp task
			{printf(" Bonito \n");}

			#pragma omp task
			{printf(" carro \n");}

			
			printf(" jajaj\n");
		}
		
/*
			int id=omp_get_thread_num();
			#pragma omp task
			{printf(" Bonito %d \n",id);}

			#pragma omp task
			{printf(" carro %d \n",id);}

			#pragma omp task
			{printf(" jajaj %d \n",id);}

			#pragma omp taskwait
			printf(" jajaj\n");
		*/
	}


	return 0;
}