#include <stdio.h>
int main()
{
    int n = 0;
    int c0, c1, c2, c3, c4, c5, c6, c7, c8, c9;
    c0 = c1 = c2 = c3 = c4 = c5 = c6 = c7 = c8 = c9 = 0;
    printf("enter number");
    while (n != -1)
    {
        scanf("%d", &n);
        while (n > 0)
        {
            int digit;
            digit = n % 10;
            switch (digit)
            {
            case 0:
                c0++;
                break;
            case 1:
                c1++;
                break;
            case 2:
                c2++;
                break;
            case 3:
                c3++;
                break;
            case 4:
                c4++;
                break;
            case 5:
                c5++;
                break;
            case 6:
                c6++;
                break;
            case 7:
                c7++;
                break;
            case 8:
                c8++;
                break;
            case 9:
                c9++;
                break;
            }
            n = n / 10;
        }
    }
    printf("0:%d,1:%d,2:%d,3:%d,4:%d,5:%d,6:%d,7:%d,8:%d,9:%d,", c0, c1, c2, c3, c4, c5, c6, c7, c8, c9);

    return 0;
}