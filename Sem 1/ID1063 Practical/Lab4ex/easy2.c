/*
Dec 29th. Problem 1.3.

Roll Number:me21btech11001
Name: Abhishek Ghosh

 */

#include <stdio.h>
int fact(int n)
{
    int fac = 1;

    for (int i = 1; i <= n; i++)
    {
        fac = fac * i;
    }
    return fac;
}
int main()
{
    int n;
    while (scanf("%d", &n) != -1)
    {
        // Call your function with argument n here
        printf("%d\n", fact(n));
    }

    return (0);
}
