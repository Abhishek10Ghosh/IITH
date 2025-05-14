/*
hackathon 5
Problem 3
Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>
int my_strlen(char s[]) // for finding the string length
{
  int count = 0;
  for (int i = 0; s[i] != '\0'; i++)
  {
    count++;
  }
  return count;
}
int main()
{
  int x[100], y[100];
  int i, j, c;
  char n1, n2;
  char s1[101], s2[101];
  int ans[200] = {0};
  scanf(" %s", s1);
  scanf(" %s", s2);
  if (s1[0] == '-')
  {
    n1 = '-';
    for (i = 0; i < my_strlen(s1) - 1; i++)
    {
      s1[i] = s1[i + 1];
    }
    s1[i] = '\0';
  }
  if (s2[0] == '-')
  {
    n2 = '-';
    for (i = 0; i < my_strlen(s2) - 1; i++)
    {
      s2[i] = s2[i + 1];
    }
    s2[i] = '\0';
  }
  int l1 = my_strlen(s1);
  int l2 = my_strlen(s2);
  // storing the string in int format
  for (i = l1 - 1, j = 0; i >= 0; j++, i--)
  {
    x[j] = s1[i] - '0';
  }
  for (i = l2 - 1, j = 0; i >= 0; j++, i--)
  {
    y[j] = s2[i] - '0';
  }
  for (i = 0; i < l2; i++) // multiplication
  {
    for (j = 0; j < l1; j++)
    {
      ans[i + j] += y[i] * x[j];
    }
  }
  for (i = 0; i < l1 + l2; i++)
  {
    c = ans[i] / 10;
    ans[i] = ans[i] % 10;
    ans[i + 1] = ans[i + 1] + c;
  }
  for (i = l1 + l2; i >= 0; i--)
  {
    if (ans[i] > 0)
      break;
  }
  if (n1 == '-' ^ n2 == '-') // check for negative int using XOR operator
    printf("-");
  for (; i >= 0; i--)
  {
    printf("%d", ans[i]);
  }
  return 0;
}