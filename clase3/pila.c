#include <stdio.h>
#include <iostream>

using namespace std;

int max(int a, int b){
	
	int m=a;
	if(b>m) m=b;

	return m;
}

int max3(int a,int b,int c){

	return max(a,max(b,c));
}

int main(){
	
	int x,y,z;
	cout<<"Ingrese tes numeros enteros"<<endl;
	cin >>x>>y>>z;
	cout<<"el maximo de " <<x << "y "<<y<<" es "<<" "<<max(x,y)<<endl;
	cout<<"el maximo de" <<x<<","<< y<<","<<z<<"es "<<" "<<max3(x,y,z)<<endl;


	return 0;
}
