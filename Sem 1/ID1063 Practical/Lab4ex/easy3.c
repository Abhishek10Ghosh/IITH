#include <stdio.h>
int main()
{
    int arr[20];
    int n;
    printf("Enter a number less than 20\n");
    scanf("%d", &n);
    printf("enter %d elements of array\n", n);
    for (int i = 0; i < n; i++)
    {
        scanf("%d", &arr[i]);
    }
    int count = 0;
    for (int j = 0; j < n; j++)
    {
        for (int i = 0; i < n; i++)
        {
            if (arr[i] == arr[j] && i != j)
            {
                count++;
                break;
            }
        }
    }
    printf("%d", count);

    return 0;
}