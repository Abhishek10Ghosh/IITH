#include <stdio.h>
int main(int argc, char const *argv[])
{
    for (int i = 0; i < argc; i++)
    {
        printf("value at index %d is %s\n",i,argv[i]);
    }
    
    return 0;
}
