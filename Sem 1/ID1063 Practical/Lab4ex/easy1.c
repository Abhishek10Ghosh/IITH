#include <stdio.h>

int main()
{
    char str[20], shift_str[20];
    int n;
    printf("enter string\n");
    scanf("%s", str);
    printf("enter number\n");
    scanf("%d", &n);
    int i = 0;
    while (str[i] != '\0')
    {
        shift_str[i] = str[i] + n;
        printf("%c", shift_str[i]);
        i++;
    }

    return 0;
}