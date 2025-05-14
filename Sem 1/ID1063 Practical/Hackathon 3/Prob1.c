/*
hackathon 3
problem 1

Roll Number:me21btech11001
Name:Abhishek Ghosh

 */

#include <stdio.h>
unsigned long int power(unsigned long int m, int k)
{
    if (k == 0)
    {
        return 1;
    }
    if (k % 2 == 0)
    {
        return (power(m, k / 2) * power(m, k / 2));
    }
    else
        return (m * power(m, k / 2) * power(m, k / 2));
}

int main()
{
    int k;
    unsigned long int m;
    while (scanf("%lu %d", &m, &k) != -1)
    {

        printf("%lu\n", power(m, k));
    }

    return (0);
}
