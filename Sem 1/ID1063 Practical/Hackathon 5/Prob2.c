/*
hackathon 5
Problem 2
Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>
int Rcirculant(int n, int arr[][100]) // function to check circulant
{
  for (int i = 0; i < n - 1; i++)
  {
    for (int j = 0; j < n - 1; j++)
    {
      if (arr[i][j] != arr[i + 1][j + 1])
      {
        return 0;
      }
    }
  }
  return 1;
}
int Lcirculant(int n, int arr[][100]) // function to check circulant
{
  for (int i = 0; i < n-1; i++)
  {
    for (int j = 0; j < n; j++)
    {
      if ( j > 0)
      {
        if (arr[i][j] != arr[i + 1][j - 1])
        {
          return 0;
        }
      }
    }
  }
  return 1;
}

int main()
{
  int n;
  scanf("%d\n", &n);

  int arr[100][100];

  for (int i = 0; i < n; i++)
  {
    for (int j = 0; j < n; j++)
    {
      scanf("%d", &arr[i][j]);
      if (j < n - 1)
      {
        printf(" ");
      }
    }
    printf("\n");
  }
  if ((Rcirculant(n, arr) == 1) || (Lcirculant(n, arr) == 1)) // conditon
  {
    printf("Yes");
  }
  else
    printf("No");

  return (0);
}
