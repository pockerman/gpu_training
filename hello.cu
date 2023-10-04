#include <iostream>
#include <cuda.h>
#include <stdio.h>

__global__ void hello(){

	printf("Hello world\n");
}

int main(){

hello<<<1, 10>>>();

// wait until all threads execute
cudaDeviceSynchronize();

//reset the device
cudaDeviceReset();

return 0; 
}
