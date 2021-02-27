#include <stdio.h>
#include <stdlib.h>

int foo(int bar){

return bar+1;

}


int foo2(int bar){

return 2*foo(bar);

}


int main(){

    printf("%d\n", foo2(0));
    char* str = NULL;
    str[0] = 'a';
    printf(NULL);

    return 0;
}