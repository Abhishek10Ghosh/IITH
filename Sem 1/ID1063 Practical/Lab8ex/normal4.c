#include <stdio.h>
int main(int argc, char const *argv[])
{
    FILE *fp;
    char str[100];
    fp = fopen(argv[1], "r");
    if (fp == 0)
    {
        printf("cannot open");
        return 0;
    }
    fgets(str, 100, fp);
    printf("%s", str);
    return 0;
}