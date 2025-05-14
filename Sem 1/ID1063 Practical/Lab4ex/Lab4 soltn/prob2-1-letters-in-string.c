#include<stdio.h>

int main(){

    char pat[20]; //Declare a char array of 20 to hold the pattern
    char str[20]; //Declare a char array of 20 to hold the actual str
    char occur[20]; //Delcare a char array of 20 to store occurences

    int i=0,j=0,len=0;

    scanf("%s%s", pat, str); //Taking input of both strings

    //Initializing occurences of each index as 0
    while(pat[i]!='\0')
    {
	occur[i]=0;
	i++;
    }

    len=i; //To get length of the occurence array
    i=0;

    //Loop over the pattern string
    while(pat[i]!='\0')
    {
	j=0;

	//Loop over the actual string
	while(str[j]!='\0')
	{
	    //if characters are same 
	    if(pat[i]==str[j])
	    {
		occur[i]++; //Increasing the occurence of that index
	    }
	    j=j+1;
	}
	i=i+1;
    }

    //Print the occurence array
    for(int i=0;i<len;i++)
	printf("%d ",occur[i]);

    return 0;
}
