#include<stdio.h>

//A function that computes factorial recursively
int fac(int n) {

    if (n>1) {
	return n*fac(n-1);
    }
    else {
	return 1;
    }

}

int main(){
    int n, out;  

    while(scanf("%d",&n) != -1){
	out = fac(n);
	printf("%d\n", out);
    }  

    return 0;
}
