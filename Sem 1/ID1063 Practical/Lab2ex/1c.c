#include<stdio.h>
int main()
{
    int prod=20,i=1, a;
   for ( i = 1; i < prod; i++)  
   {
       if (prod%i==0) {
           a=prod/i;
           printf("%d,%d\n",i,a);
       }
   }
   
    
     return 0;

}