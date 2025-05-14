#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
int sum(int n)
{
    int m, sum = 0;
    while (n > 0)
    {
        m = n % 10;
        sum = sum + m;
        n = n / 10;
    }
    return sum;
}

int main()
{
    int n, m, i, gcd;
    scanf("%d", &n);
    int c = sum(n);

    for (i = 1; i <= n && i <= c; ++i)
    {
        if (n % i == 0 && c % i == 0)
        {
            gcd = i;
        }
        }

    printf("%d", gcd);
}