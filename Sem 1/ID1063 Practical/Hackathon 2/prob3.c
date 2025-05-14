/*
hackathon 2
Problem 3

Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>

void patcheck(char str[], char pat[], int n)
{
    int x, y, j, g = 0;
    for (int i = 0; pat[i] != 0; i++)
    {
        x = i + 1;
    }

    for (int i = 0; str[i + x - 1]; i++)
    {
        y = i;

        for (j = 0; j <= x - 1; j++)
        {

            if (pat[j] != str[y])
            {
                break;
            }
            y++;
        }
        if (j == x)
        {
            g = 100;
            printf("%d ", i);
        }
    }
    if (g != 100)
    {
        printf("-1");
    }
}

int main()
{
    int n;
    scanf("%d\n", &n);
    char *str;
    str = (char *)malloc(sizeof(char) * n);
    scanf("%s\n", str);
    char *pat;
    pat = (char *)malloc(sizeof(char) * n);

    while (scanf("%s", pat) != -1)
    {
        patcheck(str, pat, n);

        printf("\n");
    }

    return (0);
}
