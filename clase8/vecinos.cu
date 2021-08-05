// main.cu 
#include <iostream> 
#include <ctime> 
#include <cuda.h>
#include <device_launch_parameters.h>

#include <cuda_runtime.h> // For float3 structure

using namespace std; 

__global__ void FindClosetsGPU(float3* points, int* indices, int count){
	
	if(count<=1) return;

	int idx= threadIdx.x + blockDim.x * blockIdx.x;

	if(idx < count){

		float distToClosets= 3.40282e38f;

		for (int i=0;i<count;i++){

			if(i==idx) continue;

			float dist= ((points.x[idx]-points[i].x)*(points.x[idx]-points[i].x) + (points.y[idx]-points[i].y)*(points.y[idx]-points[i].y) + (points.z[idx]-points[i].z)*(points.z[idx]-points[i].z));

			if(dist<distToClosets){
				distToClosets=dist;
				indices[idx]=i;
			}

		}



	}
}



int main(){
	
	const int count=10000;

	int *indexOfClosest= new int[count];

	float3 *points=new float3[count];
	float3 *d_points;
	int *d_indexOfClosest;

	for(int i=0;i<count;i++){

		points[i].x=(float)((rand()%1000)-5000);
		points[i].y=(float)((rand()%1000)-5000);
		points[i].z=(float)((rand()%1000)-5000);
	}


	cudaMalloc(&d_points,sizeof(float3)*count);
	cudaMemcpy(d_points,points,sizeof(float3)*count,cudaMemcpyHostToDevice);

	cudaMalloc(&d_indexOfClosest,sizeof(int)*count);

	return 0;
}