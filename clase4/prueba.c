#include <stdio.h>

int main(){
	
	float a[3]={1.0,2.0,3.0};

	float *p;

	p=a;

	for (int i=0;i<3;i++){
		printf(" %f ",a[i]);
	}
	

	return 0;
}