// counting odd and even numbers in given array
#include<stdio.h>
int main()
{
   int odd,even;
   int a[5];
   odd=even=0;
  
   for (int i = 0; i <5; i++)
   {
    printf("enter elements of array\n");
    scanf("%d\n",&a[i]);
   }
   for (int i = 0; i < 5; i++)
   {
       if ( a[i]%2==0)
       {
           even++;
       }
       else{
           odd++;
       }
       
   }
   printf("total even numbers=%d\nTotal odd numbers =%d",even,odd);
   
   





    return 0;
}