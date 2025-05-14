#include <stdio.h>
float absolute(float x) {
  return x>0? x : (-1*x);  
}
float newtonRoot(float  n, float epsilon) {
  float guess = 1;
  while (absolute(guess*guess - n) > epsilon) {
    guess = guess - (guess*guess - n)/(2*guess);
  }
  return guess;
}
int main() {
  float n, precision, digits;
  int count = 0;
  scanf("%f %f", &n, &precision);
    for(digits = precision; digits < 1; digits = digits*10){
    count = count+1;
  }
  
  printf("%.*f\n", count , newtonRoot(n, precision));
  return 0;
  
}
