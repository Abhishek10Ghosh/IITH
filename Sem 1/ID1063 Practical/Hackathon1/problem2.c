/*
7th Jan, 2022
Problem 2

Roll Number:me21btech11001
Name: Abhishek Ghosh

 */

#include <stdio.h>

int proper(int, int);
int proper(int a, int b)
{
    int g;
    for (int i = 1; i <= b && i <= a; i++)
    {
        if (a % i == 0 && b % i == 0)
        {
            g = i;
        }
    }
    a = a / g;
    b = b / g;
    return g;
}
int main()
{
    int a, b, p;

    while (scanf("%d %d", &a, &b) != -1)
    {
        p = proper(a, b);
        a = a / p;
        b = b / p;
        printf("%d/%d\n", a, b);
    }
    return 0;
}
