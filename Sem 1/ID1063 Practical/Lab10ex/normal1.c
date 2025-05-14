#include <stdio.h>
struct cplx
{
    float real;
    float imag;
};
typedef struct cplx complex;
complex create_cplex(float a, float b)
{
    complex A;
    A.real = a;
    A.imag = b;
    return A;
}
complex multiply(complex a, complex b)
{
    complex c;
    c.real = a.real * b.real - a.imag * b.imag;
    c.imag = a.real * b.imag + a.imag * b.real;
    return c;
}
void print_cplex(complex a)
{
    printf("%f + %fi", a.real, a.imag);
}

int main()
{
    complex c1, c2, c3;
    float r1, r2, i1, i2;
    printf("Enter real and imaginary part of complex number 1:\n");
    scanf("%f %f", &r1, &i1);
    printf("Enter real and imaginary part of complex number 2:\n");
    scanf("%f %f", &r2, &i2);
    c1 = create_cplex(r1, i1);
    c2 = create_cplex(r2, i2);
    c3 = multiply(c1, c2);
    print_cplex(c3);
    return 0;
}