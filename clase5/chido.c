#include <omp.h>
#include <stdio.h>

int main(){
	
	omp_set_num_threads(4);

	#pragma omp parallel
	{
		int id=omp_get_thread_num();

		printf(" hello (%d)",id);
		printf(" world (%d)",id);


	}

}