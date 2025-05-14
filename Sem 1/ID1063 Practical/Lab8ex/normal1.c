#include <stdio.h>
#include <string.h>
int my_strlen(char *s)
{
    int length = 0;
    while (*s != '\0')
    {
        length++;
        s++;
    }
    return length;
}
int my_strcmp(char *s1, char *s2)
{
    while (*s1 != '\0' && *s2 != '\0' && *s1 == *s2)
    {
        s1++;
        s2++;
    }
    if (*s1 == *s2)
    {
        return 0;
    }
    else
        return *s1 - *s2;
}
void my_strcpy(char *t, char *s)
{
    while (*s != '\0')
    {
        *t = *s;
        s++;
        t++;
    }
    *t == '\0';
}
int main()
{
    char str1[] = "hungry", str2[20], str3[] = "hungry boy";
    // printf("Length of sting is %d", my_strlen(str1));
    // my_strcpy(str2,str1);
    // printf("originaal=%s\ncopied=%s",str1,str2);
    printf("String compare is %d\n ", my_strcmp(str1, str3));
    printf("String compare using string.h is %d\n", strcmp(str1, str3));
    return 0;
}