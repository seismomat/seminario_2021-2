#include <stdio.h>
#include <stdlib.h>


double** malloc_fill(double **A,int tam){

  A= (double**)malloc(tam*sizeof(double));
  for(int k=0;k<tam;k++){
    A[k]=(double *)malloc(tam*sizeof(double));

  }

  for (int k=0;k<tam;k++){
    for (int j=0;j<tam;j++){
      A[k][j]=(double)((rand()%10000) - 5000);
    }
  }

  return A;
}

double** malloc_zeros(double **A,int tam){

  A= (double**)malloc(tam*sizeof(double));
  for(int k=0;k<tam;k++){
    A[k]=(double *)malloc(tam*sizeof(double));

  }

  for (int k=0;k<tam;k++){
    for (int j=0;j<tam;j++){
      A[k][j]=0.0;
    }
  }

  return A;
}


double** seq_matmul(int m, int n, int p , double** A,double** B,double** C){

	int i,j,k;

	for (i=0;i<m;i++){

		for(j=0;j<n;j++){

			C[i][j]=0.0;

			for(k=0;k<p;k++){
				C[i][j]+= A[i][k]*B[k][j];
			}
		}
	}

	return C;
}