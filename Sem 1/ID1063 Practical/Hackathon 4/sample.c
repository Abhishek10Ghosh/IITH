#include<stdio.h>
int patcheck(char str[], char pat[]) // function to check for substring from hackathon 2
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
            return 1;
        }
    }
    if (g != 100)
    {
        return 0;
    }
}
int main()
{
    char str[]="He is teaching";
    char pat[]=".t";
    int n=patcheck(str,pat);
    printf("%d\n",n);
    return 0;
}