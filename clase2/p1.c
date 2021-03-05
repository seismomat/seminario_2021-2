#include <stdio.h>

int main(){

	float a=20.0, b=50.0;
	float *pa, *pb;

	pa=&a; pb=&b;

	printf("direccion de mem de a: %p \n ",&a);
	printf("direccion de mem de pa: %p \n",&pa);

	printf(" a: %f \n ",a);
	printf(" pa : %p \n",pa);
	printf(" valor pa %f \n",*pa);

return 0;
}
