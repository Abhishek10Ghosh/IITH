#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
void RandomNumber(int n)
{
    int low = pow(10, n - 1) - 1;
    int high = pow(10, n);
    // printing random number in range of (10^(n-1)-1,10^n)
    int y = (rand() % (high - low + 1)) + low;
    printf("%d\n", y);
}
void RandomString(int n)
{
    char str[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int len = strlen(str);
    char ran[n + 1];
    for (int i = 0; i < n; i++)
    {
        int y = (rand() % (len - 0 + 1)) + 0;  //using random index number of given string
        ran[i] = str[y];
    }
    ran[n] = '\0';
    printf("%s", ran);
}
int main()
{
    int n;
    srand(time(0));
    scanf("%d", &n);
    RandomNumber(n);
    RandomString(n);

    return 0;
}