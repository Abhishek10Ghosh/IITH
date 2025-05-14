#include <stdio.h>
int clas(char str[])
{
	int i = 0, j, k = 0;
	char f[20];
	while (str[i] != '\0')
	{
		if (str[i] == ')')
		{
			f[i] = '(';
		}
		else
		{
			f[i] = '[';
		}
		i++;
	}
	i = 0;
	while (str[i] != '\0')
	{
		if (str[i] == ')' || str[i] == ']')
		{
			for (j = i - 1; j >= 0; j--)
			{
				if (str[j] == ')' || str[j] == ']')
				{
					return 0;
				}
				else if ((str[j] == '(' || str[j] == '[') && (str[j] != f[i]))
				{
					return 0;
				}
				else if ((str[j] == '(' || str[j] == '[') && (str[j] == f[i]))
				{
					str[i] = 'x';
					str[j] = 'x';
					break;
				}
			}
		}
		i++;
	}
	i = 0;
	while (str[i] != '\0')
	{
		if (str[i] != 'x')
		{
			k = 1;
		}
		i++;
	}
	if (k == 0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

int main()
{
	char str[20];
	while (scanf("%s", &str) != -1)
		printf("%d\n", clas(str));
}
