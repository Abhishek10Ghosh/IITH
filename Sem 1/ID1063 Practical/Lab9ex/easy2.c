#include <stdio.h>
int main()
{
    int r,c;
    printf("enter row and column\n");
    scanf("%d %d",&r,&c);
    int m1[r][c], m2[r][c];
    printf("First matrix\n");
    for (int i = 0; i < r; i++)
    {
        for (int j = 0; j < c; j++)
        {
            scanf("%d ", &m1[i][j]);
        }
        printf("\n");
    }
    printf("second matrix\n");
    for (int i = 0; i < r; i++)
    {
        for (int j = 0; j < c; j++)
        {
            scanf("%d ", &m2[i][j]);
        }
        printf("\n");
    }
    printf("sum is\n");
    for (int i = 0; i < r; i++)
    {
        for (int j = 0; j < c; j++)
        {
            printf("%d ",m1[i][j]+m2[i][j]);
        }
        printf("\n");
    }
    

    return 0;
}