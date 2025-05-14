/*
hackathon 4
Problem 1

Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>
int my_strlen(char *s) // works similar to strlen
{
    int length = 0;
    while (*s != '\0')
    {
        length++;
        s++;
    }
    return length;
}
int StringToInt(char str[]) // converts string to integer using ascii
{
    int len = my_strlen(str);
    int n = 0;
    for (int i = 0; i < len; i++)
    {
        n = n * 10 + (str[i] - '0');
    }
    return n;
}
int Read(FILE *fp, int n) // takes line from the given file till EOF
{
    char *p = 0, ch;
    int x = 1;
    unsigned int num_len;
    if (fp == NULL) // if reaches end/EOF terminates
    {
        return 0;
    }
    while (getline(&p, &num_len, fp) != -1)
    {
        x++;
        printf("%s", p);
        if (x > n) // for x>n for every \n it prints new line
        {
            scanf("%c", &ch);
            if (ch == '\n')
            {
                continue;
            }
            else
                break;
        }
    }
    return 0;
}

int main(int argc, char const *argv[])
{
    FILE *fp;
    fp = fopen(argv[argc - 1], "r"); // the last argument is the file name i.e argv[argc-1]
    int n;
    n = StringToInt(argv[1]);
    Read(fp, n);
    fclose(fp);

    return (0);
}
