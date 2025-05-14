#include <stdio.h>
int digits(int n)
{
    int digit, i = 0, arr[8];
    while (n > 0)
    {
        digit = n % 10;
        arr[i] = digit;
        n = n / 10;
        i++;
    }
    return arr;
}
int main()
{
    printf("enter two number");
    int n1, n2, count;
    scanf("%d %d", &n1, &n2);
    for (int i = n1; i <= n2; i++)
    {
        int c = digit(i), j=0;
        if (c[j] == 3 || c[j] == 5)
        {
        }
    }

    return 0;
}