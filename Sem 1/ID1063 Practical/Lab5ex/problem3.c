/*
5th Jan, 2022
Problem 3

Roll Number:me21btech11001
Name: Abhishek Ghosh

*/

#include <stdio.h>

/* Returns 1 if 'search' is in arr, 0 otherwise
arr is an array of n integers assumed to be in descending order. */
int bisectionSearch(int n, int arr[], int search)
{
    int first = 0;
    int last = n - 1;
    int middle = (first + last) / 2;
    while (first <= last)
    {
        if (arr[middle] < search)
        {
            last = middle - 1;
        }

        else if (arr[middle] == search)
        {
            return 1;
            break;
        }
        else

        {
            first = middle + 1;
        }
        middle = (first + last) / 2;
    }
    if (first > last)
    {
        return 0;
    }
}

int main()
{
    int n, element, search;
    int numbers[50];

    while (scanf("%d", &n) != -1)
    {
        for (int i = 0; i < n; i = i + 1)
        {
            scanf("%d", &numbers[i]);
        }
        scanf("%d", &search);
        printf("%d\n", bisectionSearch(n, numbers, search));
    }
    return 0;
}
