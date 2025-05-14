/*
hackathon 5
Problem 1
Roll Number:me21btech11001
Name:Abhishek Ghosh

 */

#include <stdio.h>
#include <stdlib.h>
int main()
{
    int m, n;
    scanf("%d %d\n", &m, &n);
    int *a, *b;
    a = (int *)malloc(sizeof(int) * m);
    b = (int *)malloc(sizeof(int) * n);
    for (int i = 0; i < m; i++) // first vector
    {
        scanf("%d", a + i);
        if (i < m - 1)
        {
            printf(" ");
        }
        else
            printf("\n");
    }

    // second vector
    for (int i = 0; i < n; i++)
    {
        scanf("%d", b + i);
        if (i < n - 1)
        {
            printf(" ");
        }
        else
            printf("\n");
    }

    // cross product
    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j < n; j++)
        {
            printf("%d ", (*(a + i)) * (*(b + j)));
        }
        printf("\n");
    }
    free(a);
    free(b);

    return (0);
}
