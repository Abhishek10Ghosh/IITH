#include <stdio.h>
int is_composite(int m)
{
    int j = 0;
    for (int i = 2; i < m; i++)
    {
        if (m % i == 0)
        {
            j = 1;
            break;
        }
    }
    return j;
}
int main()
{
    int n1, n2, c;
    printf("Enter two numbers ");
    scanf("%d \n%d", &n1, &n2);
    if (n1 > n2)
    {
        c = n1;
        n1 = n2;
        n2 = c;
    }
    for (int i = n1; i < n2; i++)
    {
        int prime = is_composite(i);
        if (prime != 1)
        {
            printf("%d,", i);
        }
    }

    return 0;
}