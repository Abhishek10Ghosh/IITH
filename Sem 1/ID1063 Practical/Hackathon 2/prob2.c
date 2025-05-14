/*
hackathon 2
Problem 2

Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>
void find(int n1, int n2, int n3, int n4)
{
    int a, r, d, c, e;
    a = n1;
    c = n3 - n2;
    e = n4 - n3;
    if (c == 0 && e == 0)
    {
        r = 1;
    }
    else
        r = e / c;

    d = n2 - n1 * r;
    printf("%d %d %d\n", a, r, d);
}

int main()
{
    int n1, n2, n3, n4;

    while (scanf("%d %d %d %d\n", &n1, &n2, &n3, &n4) != -1)
    {
        find(n1, n2, n3, n4);
    }

    return (0);
}
