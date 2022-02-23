import "dart:math";

main(){
  
  int power(int x, int n) {
    int retval = 1;
    for (int i = 0; i < n; i++) {
      retval *= x;
    }

    return retval;
  }
  
  powerArrow(int x, int n) => pow(x,n);
  
  print(power(5,5));
  print(powerArrow(5,5));
 
  