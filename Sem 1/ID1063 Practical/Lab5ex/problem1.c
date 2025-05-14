/*
5th Jan, 2022
Problem 1

Roll Number:mebtech11001
Name: Abhishek Ghosh

 */

#include <stdio.h>
int function(int);
int main()
{
    int n;

    while (scanf("%d", &n) != -1)
    {
        // Uncomment the following line and replace f(n) with a call to your function.
        printf("%d\n", function(n));
    }

    return (0);
}
int function(int n)
{
    int f1, f2, a = 0, b = 0, f_n;
    for (int i = 0; i <= n; i++)
    {
        f1 = i;
        a = a + f1;

        f2 = i * i;
        b = b + f2;
    }
    a = a * a;
    f_n = a - b;
    return f_n;
}