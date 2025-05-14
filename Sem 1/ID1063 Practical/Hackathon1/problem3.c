/*
7th Jan, 2022
Problem 3

Roll Number:me21btech11001
Name: Abhishek Ghosh

*/

#include <stdio.h>

int balanced(char expression[])
{
    int count1 = 0, count2 = 0, arr[50];

    for (int i = 0; i < 50; i++)
    {
        if (expression[i] == '\0')
        {
            break;
        }

        else if (expression[i] == '(')
        {
            count1++;
            for (int j = i + 1; j < 50; j++)
            {
                if (expression[j] == ')')
                {
                    count2++;
                    break;
                }
            }
        }
        
    }
    int count3 = 0, count4 = 0;
    for (int i = 0; i < 50; i++)
    {
        if (expression[i] == '\0')
        {
            break;
        }

        else if (expression[i] == '[')
        {
            count3++;
            for (int j = i + 1; j < 50; j++)
            {
                if (expression[j] == ']')
                {
                    count4++;
                    break;
                }
            }
        }
        
    }
    int count5, count6;
    count5 = count1 - count2;
    count6 = count3 - count4;
    if (count5 - count6 == 0)
    {
        return 1;
    }
    else
        return 0;
}

int main()
{
    int n, element, search;
    char expression[50];

    while (scanf("%s", expression) != -1)
    {
        // Call the function 'balanced' here with expression as argument.
        // Print the return value according to output format specification.
        int r;
        r = balanced(expression);
        printf("%d\n", r);
    }
    return 0;
}
