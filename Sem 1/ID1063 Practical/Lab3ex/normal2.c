// printing composite numbers less than given input
#include <stdio.h>
int main()
{
    int n;
    printf("enter a number");
    scanf("%d", &n);
    for (int i = 4; i < n; i++)
    {
        for (int j = 2; j < i; j++)

        {
            if (i % j == 0)
            {
                printf("%d,", i);
                break;
            }
        }
    }

    return 0;
}