#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main(int argc, char const *argv[])
{
    char str1[] = "ABCDEFGHIJ";
    char str2[] = "KLMNOPQR";
    char str3[] = "STUVWXYZ";
    for (int i = 1; i < argc; i++)
    {
        int n = 0;
        int len = strlen(argv[i]);
        char str[len + 1];
        strcpy(str, argv[i]);
        if (i % 3 == 1)
        {
            for (int j = 0; j < len; j++)
            {
                for (int k = 0; k < strlen(str1); k++)
                {
                    if (str[j] == str1[k])
                    {
                        n++;
                        break;
                    }
                }
            }
            printf("%d ", n);
        }

        if (i % 3 == 2)
        {
            for (int j = 0; j < len; j++)
            {
                for (int k = 0; k < strlen(str2); k++)
                {
                    if (str[j] == str2[k])
                    {
                        n++;
                        break;
                    }
                }
            }
            printf("%d ", n);
        }
        if (i % 3 == 0)
        {
            for (int j = 0; j < len; j++)
            {
                for (int k = 0; k < strlen(str3); k++)
                {
                    if (str[j] == str3[k])
                    {
                        n++;
                        break;
                    }
                }
            }
            printf("%d ", n);
        }
        free(str);
    }

    return 0;
}