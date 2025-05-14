/*
7th Jan, 2022
Problem 1

Roll Number:me21btech11001
Name: Abhishek Ghosh

*/

#include <stdio.h>
int prob(int n, int a, int b)
{
    int sum1 = 0, sum2 = 0, sum3 = 0, sum;
    for (int i = a; i < n; i++)
    {
        if (i % a == 0 && i % b != 0)
        {
            sum1 = sum1 + i;
        }
    }
    for (int j = b; j < n; j++)
    {
        if (j % a != 0 && j % b == 0)
        {
            sum2 = sum2 + j;
        }
    }
    for (int k = 1; k < n; k++)
    {
        if (k % a == 0 && k % b == 0)
        {
            sum3 = sum3 + k;
        }
    }

    sum = sum1 + sum2 + sum3;
    return sum;
}
int main()
{
    int n, a, b;

    while (scanf("%d %d %d", &n, &a, &b) != -1)
    {
        printf("%d\n", prob(n, a, b));
    }
    return 0;
}
