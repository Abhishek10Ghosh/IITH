/*
hackathon 5
Problem 5
Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>
int max(int x, int y) //returns greater of the two
{
  return (x >= y) ? x : y;
}
int main()
{
  int n;
  scanf("%d\n", &n);
  int arr[300][300];
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
  int arrnew[300][300];//cost matrix array
  arrnew[n - 1][0] = arr[n - 1][0];
  for (int j = 1; j < n; j++)  // bottom most row
  {
    arrnew[n - 1][j] = arr[n - 1][j] + arrnew[n - 1][j - 1];
  }
  for (int i = n - 2; i >= 0; i--) //left most column
  {
    arrnew[i][0] = arr[i][0] + arrnew[i + 1][0];
  }
  for (int i = n - 2; i >= 0; i--) //rest elements
  {
    for (int j = 1; j < n; j++)
    {
      arrnew[i][j] = arr[i][j] + max(arrnew[i + 1][j], arrnew[i][j - 1]);
    }
  }
  printf("%d\n", arrnew[0][n - 1]); //the top most right element of cost matrix 
  return 0;
}