#include <stdio.h>
void foo(int **a, int **b)
{
    int t;
    t = (int)*a;
    *a = *b;
    *b = t;
}
int main()
{
    int var1, var2;
    int *ptr1, *ptr2;

    ptr1 = &var1;
    ptr2 = &var2;

    printf("ptr1=%u ptr2=%u\n", ptr1, ptr2);
    foo(&ptr1, &ptr2);
    printf("ptr1=%u ptr2=%u\n", ptr1, ptr2);

    return 0;
}