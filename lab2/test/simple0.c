#include<stdio.h>


int a (int b){


return b+2;

  }


int b(char* chars){


  return 1;
}

int main() {

  a(1);
  b("foo");
  printf("bar");

  int x = 0;
  int y = x;
  int w = x  & 2;
  int z = y / x; // Divide by zero

 
  
  return 0;
}
