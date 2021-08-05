#include <stdio.h>
#include <mpi.h>

static long num_steps=100000000;
double step;

 int main(int argc, char** argv){

 	int i;
 	int n, my_id, nprocs;
 	double start_time,final_time;
 	double x,sum,pi, my_pi;


 	MPI_Init(&argc,&argv);
 	MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
 	MPI_Comm_rank(MPI_COMM_WORLD, &my_id);


 	start_time=MPI_Wtime();

 	MPI_Barrier(MPI_COMM_WORLD);
 	MPI_Bcast(&num_steps,1,MPI_LONG,0,MPI_COMM_WORLD);


 	step= 1.0/(double)num_steps; 

 	for(i=my_id+1;i<num_steps;i+=nprocs){

 		x=0.0;
 		x= (i -0.5)*step;
 		sum+= 4.0/(1.0+ x*x);
 	}

 	my_pi= step*sum;

 	MPI_Reduce(&my_pi,&pi,1,MPI_DOUBLE,MPI_SUM,0,MPI_COMM_WORLD);


 	final_time=MPI_Wtime() - start_time;

 	printf(" \n pi with %ld steps is %lf in %lf seconds procese %d\n",num_steps,pi,final_time,my_id);

 	MPI_Finalize();



 }