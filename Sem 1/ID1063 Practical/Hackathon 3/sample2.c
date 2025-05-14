/*
hackathon 3
problem 3

Roll Number:me21btech11001
Name:Abhishek Ghosh

 */

#include <stdio.h>
#include <stdlib.h>
void Repeat(int n, int arr[])
{
  for (int i = 0; i < n; i++)
  {
    printf("%d", arr[i]);
    if(i<n-1) printf("+");
  }
  printf("\n");
  if (n > 1)
  {
    arr[n - 2] = arr[n - 2] + arr[n - 1];
    n--;
    Repeat(n, arr);
  }
}

int main()
{
  int n;

  while (scanf("%d", &n) != -1)
  {
    int *arr;
    arr = (int *)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++)
    {
      arr[i] = 1;
    }
    Repeat(n, arr);
  }

  return (0);
}
