#include<stdlib.h>
#include<stdio.h>
#include<time.h>
#include <cuda_runtime.h>

#define N 1024

__global__ void sumaGPU(float *a, float* b, float *c){
	
	int myID= threadIdx.x + blockDim.x * blockIdx.x;

	if(myID<N){
		c[myID]= a[myID]+ b[myID];
	}

}

void 1DInitialData(float *ip,int size){
	
	for(int i=0; i<size; i++){

		ip[i]= (float) rand()/10.0;
	}

}

void print1DData(float *ip,int size){
	
	for(int i=0; i<size; i++){

		printf(" %f\n", ip[i]);
	}

}



int main(){
	
	size_t nBytes= N* sizeof(float);

	float *h_a, *h_b, *h_c;
	float *d_a, *d_b, *d_c;

 	// asignamos memoria en el host

 	h_a= (float *)malloc(nBytes);
	h_b= (float *)malloc(nBytes);
	h_c= (float *)malloc(nBytes);

	//asignamos memoria en el device

	cudaMalloc( (void**)&d_a,nBytes);
	cudaMalloc( (void**)&d_b,nBytes);
	cudaMalloc( (void**)&d_c,nBytes);

	// inicializar los arreglos

	1DInitialData(h_a,N);
	1DInitialData(h_b,N);

	// mando los datos a la ldevice

	cudaMemcpy(d_a,h_a,nBytes,cudaMemcpyHostToDevice);
	cudaMemcpy(d_b,h_b,nBytes,cudaMemcpyHostToDevice);

	// ------------ procesamiento ----------------- //

	int Blocks= 32;

	int Nhilos= N/ Blocks; 

	sumaGPU<<< Blocks, Nhilos>>>(d_a,d_b,d_c);


	// ------------ procesamiento ----------------- //

	cudaMemcpy(h_c,d_c,nBytes,cudaMemcpyDeviceToHost);

	print1DData(h_c,N);

	free(h_a);
	free(h_b);
	free(h_c);

	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);

	return 0; 
}