#include <stdio.h>
int main()
{
    int a[20], i = 0;
    char pat[20], str[20];
    printf("enter pat string less than 20\n");
    scanf("%s", pat);
    printf("enter str string less than 20\n");
    scanf("%s", str);
    for (int i = 0; i < 20; i++)
    {
        a[i] = 0;
        if (pat[i] == '\0')
        {
            break;
        }
        else
        {
            for (int j = 0; j < 20; j++)
            {
                if (str[j] == '\0')
                {
                    break;
                }
                else if (pat[i] == str[j])
                {

                    a[i]++;
                }
            }
        }
    }
    int c=0;
    while (pat[c]!='\0')
    {
        printf("%d,",a[c]);
        c++;
    }
    

    return 0;
}