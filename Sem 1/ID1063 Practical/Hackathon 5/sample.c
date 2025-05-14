#include <stdio.h>
#include <stdlib.h>
int check(int arr[], int n, int t)
{
    int sum = arr[0] + arr[1] + arr[2];
    for (int i = 0; i < n; i++)
    {
        for (int j = i + 1; j < n; j++)
        {
            for (int k = j + 1; k < n; k++)
            {
                if ((t - sum) < (t - (arr[i] + arr[j] + arr[k])))
                {
                    sum = (arr[i] + arr[j] + arr[k]);
                }
            }
        }
    }
    return sum;
}
int main()
{
    int n, t;
    scanf("%d %d", &n, &t);
    int *arr;
    arr = (int *)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++)
    {
        scanf("%d", arr + i);
        if (i < n - 1)
        {
            printf(" ");
        }
        else printf("\n");
    }
    
    int a = check(arr, n, t);
    printf("%d\n", a);

    return 0;
}