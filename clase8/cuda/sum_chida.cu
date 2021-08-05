#include <stdlib.h>
#include <stdio.h>
#include <time.h>
//#include "initial.h"
#include <cuda_runtime.h>

#define N 1024

__global__ void suma_GPU(float *a, float *b, float *c){

	int myID= threadIdx.x + blockDim.x * blockIdx.x;

	if(myID<N){
		c[myID]= a[myID]+ b[myID];
	}
}

void OneD_InitialData(float *ip, int size){

	for(int i=0; i<size;i++){

		ip[i]= (float) rand()/10.0;
	}

}

void print1D_arrays(float *pi,int size){

	for(int i=0;i<size;i++){
		printf("%f\n", pi[i]);
	}
}

int main(){

	size_t nBytes= N* sizeof(float);

	float *h_a, *h_b, *h_c;
	float *d_a, *d_b, *d_c;

	h_a=(float *)malloc(nBytes);
	h_b=(float *)malloc(nBytes);
	h_c=(float *)malloc(nBytes);

	cudaMalloc( (void**)&d_a,nBytes);
	cudaMalloc( (void**)&d_b,nBytes);
	cudaMalloc( (void**)&d_c,nBytes);


	OneD_InitialData(h_a,N);
	OneD_InitialData(h_b,N);

	cudaMemcpy(d_a,h_a,nBytes,cudaMemcpyHostToDevice);
	cudaMemcpy(d_b,h_b,nBytes,cudaMemcpyHostToDevice);

	int Blocks=32;

	int Nhilos= N/Blocks;

	suma_GPU<<<Blocks,Nhilos >>>(d_a,d_b,d_c);

	cudaMemcpy(h_c,d_c,nBytes,cudaMemcpyDeviceToHost);

	print1D_arrays(h_c,N);


	free(h_a);
	free(h_b);
	free(h_c);

	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);







	return 0;
}