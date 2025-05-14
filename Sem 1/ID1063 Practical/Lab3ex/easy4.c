// print helo world in reverse
#include<stdio.h>
int main()
{
char str[]="Hello World\n";
int len=12;
for (int  i = len-1; i>=0; i--)
{
    printf("%c", str[i]);
}





    return 0;
}