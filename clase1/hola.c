#include<stdio.h>

// funcion de tipo entero que suma y retorna la suma de a y b
int imprimir(int a,int b){

	return a+b;
}
int main(){
	
	/* int a=1;
	float b=1.25;

	printf(" %d %f ",a,b); */

	int n; // se declara la variable entera n
	printf("dame un numero entero: \n"); // se imprime un letrero
	scanf(" %d",&n); // se guarda el numero en la variable n
	printf("%d \n",n); // se muestra el numero guardado

	printf(" jajaja %i \n",imprimir(1,2));
	return 0;
}
