#include <stdio.h>

int main(){
	// seccion de variables 
	//
	int num,n;
	int A1[5]={ 1,2,3,4,5};
	int longitud=sizeof(A1);
	int i,suma=0,suma1=1;

	printf("Ingrese un numero o el numero 2 \n ");
	scanf(" %d",&num);	
							
	if(num==2) {  
		for(i=0;i<5;i++){

			suma+=A1[i];

		}
			
		printf(" la suma es : %d \n",suma);
	}
	else { 
		while(suma1<50){
			suma1*=num+1;
		}

		printf("el producto de los valores es: %d \n",suma1);

	}

return 0; 
}
