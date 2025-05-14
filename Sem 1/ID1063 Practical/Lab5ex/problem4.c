#include <stdio.h>
float root(float, float);
float max(float x, float y)
{
    if (x > y)
    {
        return x;
    }
    else
        return y;
}
int absolute(float x)
{
    return x > 0 ? x : (-1 * x);
}

int main()
{
    float n, precision;
    while (scanf("%f %f", &n, &precision) != -1)
        printf("%f\n", root(n, precision));

    return 0;
}
float root(float n, float epsilon)
{
    float r;
    float low, high;
    if (n > 1)
    {
        low = 1.0;
    }
    else
        low = n;
    high = max(n, 1.0);

    float guess = 0;
    while (absolute(guess * guess - n) > epsilon)
    {
        guess = (low + high) / 2;
        if (absolute(guess * guess - n) < epsilon)
            r = guess;
        else if (guess * guess > n)
            high = guess;
        else
            low = guess;
    }
    return r;
}