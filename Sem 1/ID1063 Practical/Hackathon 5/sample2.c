#include <stdio.h>
#include<stdlib.h>
struct Time
{
    int year;
    int months;
    int day;
    int hour;
    int min;
    int sec;
};
typedef struct Time time;

int main()
{
    time t1,t2;
    scanf("Enter year:%d month:%d\ndays%d\n",&t1.year,&t1.months,&t1.day);
    //scanf("Time in 24hr format")
    return 0;
}