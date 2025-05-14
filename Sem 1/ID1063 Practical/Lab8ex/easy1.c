#include <stdio.h>
int my_floor(float x)
{
    if (x >= 0)
    {
        return (int)x;
    }
    else if (x < 0)
    {
        return (int)x - 1;
    }
}

int main()
{
    float n;
    printf("enter number\n");
    scanf("%f\n", &n);
    int a = my_floor(n);

    printf("The floor of given number is %d ", a);

    return 0;
}