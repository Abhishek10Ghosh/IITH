/*
hackathon 3
problem 3

Roll Number:me21btech11001
Name:Abhishek Ghosh

 */

#include <stdio.h>
#include <stdlib.h>
void print(int arr[], int n);
void Repeat(int i, int n, int arr[], int ind) //function to find all the permutations 
{

    for (int j = i; j <= n; j++)
    {
        arr[ind] = j;
        Repeat(j, n - j, arr, ind + 1); // recursive call
    }
    if (n == 0)
    {
        print(arr, ind); // printing when it equals the given sum
    }
}
void print(int arr[], int n) // printing array of given length
{
    for (int i = 0; i < n; i++)
    {
        printf("%d", arr[i]);
        if (i < n - 1) // printing "+" sign and not exceeding last number
        {
            printf("+");
        }
    }
    printf("\n");
}

int main()
{
    int n;

    while (scanf("%d", &n) != -1)
    {
        int *arr;
        arr = (int *)malloc(sizeof(int) * n); // dynamic memory allocation

        Repeat(1, n, arr, 0);
    }

    return (0);
}
