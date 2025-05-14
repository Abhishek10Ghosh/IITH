// max and min of two numbers
#include<stdio.h>
int main()
{
    int a,b;
    printf("Enter two numbers");
    scanf("%d %d",&a,&b);
    if (a>b)
    {
        printf(" %d is max and %d is min",a,b);
    }
    if (a<b)
    {
         printf("%d is max and %d is min",b,a);
    }
    
    else printf("both are equal");
    return 0;
}