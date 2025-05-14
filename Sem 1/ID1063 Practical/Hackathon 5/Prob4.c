/*
hackathon 5
Problem 4
Roll Number:me21btech11001
Name:Abhishek Ghosh

*/
#include <stdio.h>
int stack[100]; // maintains stack
int top = -1;
int pop()
{
  return (stack[top--]);
}
void push(int element)
{
  stack[++top] = element;
}
int main()
{
  int i = 0, a, b;
  char expr[100], e;
  scanf("%s", expr);
  while ((e = expr[i++]) != '\0')
  {
    if (e >= '0' && e <= '9')
      push(e - '0'); // push the operation
    else
    {
      b = pop();
      a = pop();
      switch (e) // switch case to check
      {
      case '+':
        push(a + b);
        break;
      case '-':
        push(a - b);
        break;
      case '*':
        push(a * b);
        break;
      case '/':
        push(a / b);
        break;
      case '%':
        push(a % b);
        break;
      }
    }
  }
  printf("%d\n", stack[top]);
}
