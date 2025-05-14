// populating array of size 20
#include <stdio.h>
int main()
{
    int arr[20];
    for (int i = 0; i < 20; i++)
    {
        arr[i] = 3 * i * i * i + 2 * i * i + 42;
    }
    for (int i = 0; i < 20; i++)
    {
        printf("%d\n", arr[i]);
    }

    return 0;
}