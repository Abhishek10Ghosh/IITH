/*
hackathon 3
problem 2

Roll Number:me21btech11001
Name:Abhishek Ghosh

 */

#include <stdio.h>
int strLength(char s[]) // for finding the string length
{
    int count = 0;
    for (int i = 0; s[i] != '\0'; i++)
    {
        count++;
    }
    return count;
}
void Add(char str1[], char str2[])
{
    int n1[100], n2[100], sum[100]; // integer array for storing each element of string
    for (int b = 0; str1[b] != '\0'; b++)
    {
        n1[b] = str1[b];
    }
    for (int b = 0; str2[b] != '\0'; b++)
    {
        n2[b] = str2[b];
    }
    int l1 = strLength(str1);
    int l2 = strLength(str2);
    int c = 0, d = 0;           // c is the carry over
    int i = l1 - 1, j = l2 - 1; // starting from the right side
    for (i >= 0 && j >= 0; i--, j--, d++;)
    {
        sum[d] = (n1[i] + n2[j] + c) % 10;
        c = (n1[i] + n2[j] + c) / 10;
    }
    if (l1 > l2) // if one number is greater than the other
    {
        while (i >= 0)
        {
            sum[d] = (n1[i] + c) % 10;
            c = (n1[i] + c) / 10;
            d++, i--;
        }
    }
    if (l1 < l2)
    {
        while (j >= 0)
        {
            sum[d] = (n2[j] + c) % 10;
            c = (n2[j] + c) / 10;
            d++, i--;
        }
    }
    else
    {
        if (c > 0)
        {
            sum[d] = c;
            d++;
        }
    }
    for (d >= 0; d--;) // printing the final sum array in reverse order
    {
        printf("%d", sum[d]);
    }
}
int main()
{
    char str1[100], str2[100];
    while (scanf("%s\n %s", str1, str2) != -1)
    {
        Add(str1, str2);
    }

    return (0);
}
