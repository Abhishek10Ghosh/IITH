/*
5th Jan, 2022
Problem 2

Roll Number:me21btech11001
Name: Abhishek Ghosh

 */
#include <stdio.h>
int GCD(int, int);

int main()
{
    int a, b;

    while (scanf("%d %d", &a, &b) != -1)
    {
        // Uncomment the following line and replace f(a,b) with a call to your function.
        printf("%d\n", GCD(a, b));
    }

    return (0);
}
int GCD(int a, int b)
{
    int gcd, r;
    if (b % a == 0)
    {
        gcd = a;
    }
    else
    {
        r = b % a;
        gcd = GCD(r, a);
    }
    return gcd;
}