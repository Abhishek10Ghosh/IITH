#include <stdio.h>
#include <stdlib.h>

void reverse(int arr[],int n)
{
	int i,m=n;
	int *rev;
	rev=(int *)malloc(n*sizeof(int));
	for(i=0;i<n;i++)
	{
		rev[i]=arr[m-1];
		m--;
	}
	for(i=0;i<n;i++)
	{
		arr[i]=rev[i];
		printf("%d	",arr[i]);
	}
}


int main()
{
	int *arr;
	int n,i;
	scanf("%d",&n);
	arr=(int *)malloc(n*sizeof(int));
	for(i=0;i<n;i++)
	{
		scanf("%d",&arr[i]);
	}
	for(i=0;i<n;i++)
	{
		printf("%d	",arr[i]);
	}
	printf("\n");
	reverse(arr,n);
}