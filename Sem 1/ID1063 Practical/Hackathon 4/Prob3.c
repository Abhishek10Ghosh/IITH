/*
hackathon 4
Problem 3

Roll Number:me21btech11001
Name:Abhishek Ghosh

*/

#include <stdio.h>
#include <stdlib.h>
struct Queue_create
{
    int size; // size of Queue
    int fi;   // front index maintains thhe index of the first element that is removed
    int ri;   // rear index=saves the index where the latest element is stored
    int *arr; // array to store the entries of Queue
};
typedef struct Queue_create Queue;
void EnQ(Queue *Q, int n) // increses the rear index and stores the element in arr[rear index]
{

    Q->ri++;
    Q->arr[Q->ri] = n;
}
int Empty(Queue *Q)
{
    if (Q->ri == Q->fi) // if fornt and rear index points the same location then its empty
    {
        return 1;
    }
    return 0;
}
void DeQ(Queue *Q) // increses the front index count and prints the element that was removed
{
    if (Empty(Q) == 1)
    {
        printf("Empty\n");
    }
    else
    {
        Q->fi++;
        printf("%d\n", Q->arr[Q->fi]);
    }
}

int main()
{
    Queue q;
    q.size = 50;
    q.arr = (int *)malloc(sizeof(int) * q.size);
    q.fi = q.ri = 0;
    char c;
    int n;
    while (scanf("%c", &c) != -1)
    {
        if (c == 'E') // for enqueue
        {
            scanf(" %d", &n);
            EnQ(&q, n);
        }
        if (c == 'D') // for dequeue
        {
            DeQ(&q);
        }
    }
    free(q.arr); // free the memory

    return (0);
}
