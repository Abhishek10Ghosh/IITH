#include<stdio.h>

//Simple function to check if m is composite
int is_composite(int m) {
    int i;

    if(m==1) {
	return 1;
    }

    for(i=2;i<m;i++) {
	if(m%i==0) {
	    return 1;
	}
    }
    return 0;
}

int main() {
    int n1, n2;
    int i;

    //read n1 and n2
    scanf("%d", &n1);
    scanf("%d", &n2);

    //Call is_composite
    for(i=n1;i<=n2;i++){
	if(!is_composite(i)) {
	    printf("%d ", i);
	}
    } 
    return 0;
}
