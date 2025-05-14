#include <stdio.h>
int fun(int n)
{
    if (n = 0)
        return 1;
    else
    {
        if (n % 2 != 0)
        {
            return 2 * fun(n / 2);
        }
        else
            return n + 1;
    }
}
int main()
{
    int *p1;
    p1 = malloc(10);
    p1 = malloc(20);
    printf("%d", sizeof(int *));

    return 0;
}