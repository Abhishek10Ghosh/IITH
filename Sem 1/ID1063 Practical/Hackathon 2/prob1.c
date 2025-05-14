/*
Hackathon 2
Problem 1

Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>
int check(int arr[], int n, int k)
// this will check if the sum is greater,then it will subtract the first term of the subarray till the sum becomes less than the given sum
// will check if the sum of the subarray is equal to the given sum
// if the sum does not match then it adds the next term of array to the sum if none matches then returns zero
{
    int sum, l;
    sum = arr[0], l = 0;
    for (int i = 1; i <= n; i++)
    {
        while (sum > k && l <= i - 1)
        {
            sum = sum - arr[l];
            l++;
        }
        if (sum == k)
        {
            return 1;
            break;
        }
        if (i < n)
        {
            sum = sum + arr[i];
        }
    }
    return 0;
}
int main()
{
    int n, *arr, k;
    while (scanf("%d", &n) != -1)
    {
        arr = (int *)malloc(sizeof(int) * n);
        for (int i = 0; i < n; i++)
        {
            scanf("%d", &arr[i]);
        }
        scanf("%d", &k);
        printf("%d\n", check(arr, n, k));
    }

    return (0);
}
