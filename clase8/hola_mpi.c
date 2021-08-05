#include <stdio.h>
#include <mpi.h>

int my_id,nproc,result;
char name[50];

int main(int argc, char** argv){
	
	MPI_Init(&argc, &argv);

	MPI_Comm_rank(MPI_COMM_WORLD,&my_id);
	MPI_Comm_size(MPI_COMM_WORLD,&nproc);
	MPI_Get_processor_name(name,&result);

	name[result]='\0';

	printf(" Hola mundo yo soy %d de %d corriendo en %s con %d  \n ", my_id,nproc,name, result);

	MPI_Finalize();

	return 0;
}