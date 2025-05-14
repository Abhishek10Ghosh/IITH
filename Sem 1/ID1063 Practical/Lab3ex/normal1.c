// printing perfect squares less than given number
#include <stdio.h>
#include <math.h>
int main()
{
    int i, n;
    printf("enter a number");
    scanf("%d", &n);
    for (int i = 0; i * i < n; i++)
    {
        printf("%d,", i * i);
    }


    return 0;
}