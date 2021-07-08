#include <omp.h>
#include <stdio.h>

void sum_bits(int x, int y, int* sum, int* aca){

	if(x==0 && y==0){
		*sum=0;
		*aca=0;
	}
	else if(x==0 && y==1){
		*sum=1;
		*aca=0;
	}
	else if(x==1 && y==0){
		*sum=1;
		*aca=0;
	}
	else if(x==1 && y==1){
		*sum=0;
		*aca=1;
	}
}

int main(){
	
	omp_set_num_threads(4);

	int x[]={1,1,1,1},y[]={1,1,1,1};
	int aca[]={0,0,0,0},sum[]={0,0,0,0};
	int tam=sizeof(x)/sizeof(x[1]);

	#pragma omp parallel
	{
		int id,nt;
		id=omp_get_thread_num();
		nt=omp_get_num_threads();

		#pragma omp for 

			for(int i=0;i<nt;i++){
				sum_bits(x[i],y[i],&sum[i],&aca[i]);
			}

	}
	printf(" estoy fuera del pragma \n");

	for(int i=0;i<4;i++){
		printf(" %d %d \n", sum[i],aca[i]);
	}
	
	return 0;

}
