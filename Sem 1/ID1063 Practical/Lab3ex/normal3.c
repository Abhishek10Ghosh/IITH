// finding fabonacci pingala number between two given numbers
#include <stdio.h>
int main()
{
    int n1, n2, a;
    printf("enter two numbers\n");
    scanf("%d\n%d", &n1, &n2);
    if (n1 > n2)
    {
        a = n1;
        n1 = n2;
        n2 = a;
    }
    int t1 = 0, t2 = 1;
    int nextterm;
    nextterm = t1 + t2;
    for (int i = 0; i < n2; i++)

    {
        if (nextterm > n1 && nextterm < n2)
        {
            printf("%d\n", nextterm);
        }

        t1 = t2;
        t2 = nextterm;
        nextterm = t1 + t2;
    }

    return 0;
}