/*
hackathon 4
Problem 2

Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>
void my_strcpy(char *t, char *s) // similar to strcpy
{
    while (*s != '\0')
    {
        *t = *s;
        s++;
        t++;
    }
    *t == '\0';
}
int my_strlen(char *s) // similar to strlen
{
    int length = 0;
    while (*s != '\0')
    {
        length++;
        s++;
    }
    return length;
}
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
void simpleGrep(FILE *fp, char str[])
{
    // removing "" from the word
    int len = my_strlen(str);
    char arr[len - 1];
    for (int i = 1; i < len - 1; i++)
    {
        int j = 0;
        arr[j] = str[i];
        j++;
    }
    arr[len - 1] = '\0';
    // finding given substring in the line
    char *p;
    unsigned int num_len;
    while (getline(&p, &num_len, fp) != -1)
    {
        int n = patcheck(p, arr);
        if (n == 1)
        {
            printf("%s", p);
        }
    }
    free(arr);
}
int main(int argc, char const *argv[])
{
    int l1;
    char str[13];
    l1 = my_strlen(argv[argc - 2]);
    char word[l1 + 1];
    my_strcpy(str, argv[1]);
    FILE *fp;
    fp = fopen(argv[argc - 1], "r");
    my_strcpy(word, argv[argc - 2]);
    if (str == "./simpleGrep")
    {
        simpleGrep(fp, word);
    }
    fclose(fp);

    return (0);
}
