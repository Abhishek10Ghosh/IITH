#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
int main()
{
    srand(time(0));
    int x = rand();
    FILE *ptr = NULL;
    ptr = fopen("word.txt", "r");
    if (ptr == NULL)
    {
        printf("Cannot open file \n");
        exit(0);
    }
    return 0;
}
