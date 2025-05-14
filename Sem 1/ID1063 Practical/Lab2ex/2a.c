#include<stdio.h>
int main()
{
    int n=5, count;
    while (n>0)
    {
        count=0;
        while(count<n){
            printf("*");
            count++;    
        }
        printf("\n");
        n--;
    }
    return 0;

}