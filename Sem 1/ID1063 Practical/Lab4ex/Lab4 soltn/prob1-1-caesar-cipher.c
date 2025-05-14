#include<stdio.h>

int main(){
    int i;
    int n;
    char str[20];

    //Read str and n
    scanf("%s",str);
    scanf("%d", &n);

    //Take each character of str and ascii-shift it by n

    for (i=0; str[i]!='\0'; i++){
	printf("%c", (char)(str[i]+n));
    }

    return 0;
}
