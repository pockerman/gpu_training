#include <iostream>
#include <cuda.h>
#include <stdio.h>

//#include "cuda_utils.h"


__global__ void hello(){

	printf("Hello world\n");
}

int main(){

hello<<<1, 10>>>();
cudaDeviceSynchronize();

return 0; 
}
