/* Write a program that reads an integer n from the user. Then, it populates the first
n Fibonacci-Pingala numbers into any array FibPin. Then, it populates an array
FibPinSq with the square of FibPin. Then, it prints out the pair (FibPin[i],
FibPinSq) for all i.*/
#include <stdio.h>
int main()
{
    int n;
    printf("enter a nymber\n");
    scanf("%d", &n);
    int t1 = 0, t2 = 1;
    int nextterm;
    nextterm = t1 + t2;
    int fibpin[100];
    for (int i = 0; i < n; i++)
    {
        fibpin[i] = nextterm;
        t1 = t2;
        t2 = nextterm;
        nextterm = t1 + t2;
    }
    int fibpinsq[100];
    for (int i = 0; i < n; i++)
    {
        fibpinsq[i] = fibpin[i] * fibpin[i];
    }
    printf("fibpin,fibpinsq\n");
    for (int i = 0; i < n; i++)
    {

        printf("%d,%d\n", fibpin[i], fibpinsq[i]);
    }

    return 0;
}
