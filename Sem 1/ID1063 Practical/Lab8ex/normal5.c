#include <stdio.h>
int main(int argc, char const *argv[])
{
    FILE *ptr;
    char ch;
    ptr = fopen(argv[1], "r");
    if (ptr == NULL)
    {
        puts("cannot open");
        return 0;
    }
    int cc = 0, wc = 1, lc = 0;
    while (1)
    {
        ch = fgetc(ptr);
        if (ch == EOF)
        {
            break;
        }
        cc++;
        if (ch == '\n')
        {
            lc++;
        }
        if (ch == ' ')
        {
            wc++;
        }
    }
    printf("charcter count=%d\nline count=%d\nword count=%d\n", cc, lc, wc);

    return 0;
}