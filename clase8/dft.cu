#include <stdlib.h>
#include <stdio.h>
#include <cuda_runtime.h>
#include <math.h>
#include <iostream>
#include<fstream>

#define Pi 3.141516
#define Nthreads 32 

using namespace std; 

__global__ void Sinodails(double* cosine, double* sine, int tam){
	
		int Id= threadIdx.x + blockDim.x* blockIdx.x;

		if(Id<tam){

			for(int i=0;i<tam;i++){
				cosine[Id*tam+i]=cos((2 * Id * i * Pi) / tam);
				sine[Id*tam+i]= sin((2 * Id * i * Pi) / tam);
			}

		}
}

__device__ double GetAmp(double real, double im)
{
    return sqrt(real*real+im*im);
}

__global__ void DFT(double* signal, double* cosine, double* sine, int tam, double* spectrum){
	
	int Id= threadIdx.x + blockDim.x* blockIdx.x;

	extern __shared__ double Shasignal[];

	double temp1, temp2;

	Shasignal[threadIdx.x]=signal[threadIdx.x];

	 __syncthreads();


	 for(int i=0;i<tam;i++){
	 	temp1+= cosine[Id*tam +i]*Shasignal[i];
	 	
	 	temp2+= sine[Id*tam +i]*Shasignal[i];
	 }


	spectrum[Id]=GetAmp(temp1,temp2);
	__syncthreads();

	printf(" jaja");
}

void Signals(double *signal,double *time,int tam){
	
	double dt=0.02;

for(int i=0;i<tam;i++){
	double R1 = (double) rand() / (double) RAND_MAX;
	double R2 = (double) rand() / (double) RAND_MAX;

	signal[i] = (double) sqrt( -2.0f * log( R1 )) * cos( 2.0f * Pi * R2 );
	time[i]=i*dt;

	}


}

int main(){

	// host variables
	double *signal, *time;
	double *cosine, *sine;
	double *spectrum;
	int tam=256;
	size_t dBytes=tam*sizeof(double);
	size_t ddBytes=tam*tam*sizeof(double);

	// device variables 
	double *d_cosine, *d_sine;
	double *d_signal;
	double *d_spectrum;

	// kernel variables 

	int Blocks= tam/Nthreads;


	// -------------------------  BODY ------------------ /////

	cosine= (double*)malloc(ddBytes);
	sine=(double*)malloc(ddBytes);
	spectrum=(double*)malloc(dBytes);
	signal=(double*)malloc(dBytes);
	time=(double*)malloc(dBytes);

	Signals(signal,time,tam);


	/// ---------------------------------------------------

	// we allocate cosine and sine arrays

	cudaMalloc((void**)&d_cosine,ddBytes);
	cudaMalloc((void**)&d_sine,ddBytes);


	Sinodails<<<Blocks,Nthreads>>>(d_cosine,d_sine,tam);

	cudaDeviceSynchronize();
	/// ---------------------------------------------------
	
	cudaMalloc((void**)&d_spectrum,dBytes);
	cudaMalloc((void**)&d_signal,dBytes);
	cudaMemcpy(d_signal,signal,dBytes,cudaMemcpyHostToDevice);

	DFT<<<Blocks,Nthreads,dBytes >>>(d_signal,d_cosine,d_sine,tam,d_spectrum);

	cudaDeviceSynchronize();

	cudaMemcpy(spectrum,d_spectrum,dBytes,cudaMemcpyDeviceToHost);
	// -------------------------  BODY ------------------ /////


	/// ---------------

	ofstream file1,file2;
  	file1.open("fourier.dat");
  	file2.open("signal.dat");
    
    for (int i=0; i<tam;i++){
    	file1<<time[i]<<" "<<spectrum[i]<<endl;
    	file2<<time[i]<<" "<<signal[i]<<endl;
    }

  	
  /// ---------------
	ofstream file3;

	file3.open("imprimir.gnu");

	file3<<"set terminal eps transparent size 6,4 lw 1.8 enhanced font \"Times,24\""<<endl;
	file3<<"set encoding iso_8859_1"<<endl;
	file3<<"set title 'fourier'"<<endl;
	file3<<"set output \"imprimir.eps\""<<endl;
	file3<<"set grid"<<endl;
	file3<<"set xrange[0:5]"<<endl;
	file3<<"set yrange[0:10]"<<endl;
	//file3<<"set datafile separator whiteespace"<<endl;
	file3<<"plot 'fourier.dat' w l"<<endl;
	file3.close();

	system("gnuplot imprimir.gnu");
	system(" evince imprimir.eps");

  /// ----------------

    /// ---------------
	ofstream file4;

	file4.open("imprimir1.gnu");

	file4<<"set terminal eps transparent size 6,4 lw 1.8 enhanced font \"Times,24\""<<endl;
	file4<<"set encoding iso_8859_1"<<endl;
	file4<<"set title 'Senal'"<<endl;
	file4<<"set output \"imprimir1.eps\""<<endl;
	file4<<"set grid"<<endl;
	file4<<"set xrange[0:5]"<<endl;
	file4<<"set yrange[-3:3]"<<endl;
	//file3<<"set datafile separator whiteespace"<<endl;
	file4<<"plot 'signal.dat' w l"<<endl;
	file4.close();

	system("gnuplot imprimir1.gnu");
	system(" evince imprimir1.eps");

  /// ----------------
	cudaFree(d_cosine);
	cudaFree(d_sine);
	cudaFree(d_signal);
	free(cosine);
	free(sine);
	free(signal);

	return 0; 
}


