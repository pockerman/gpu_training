#include <iostream>
#include <cuda.h>
#include <stdio.h>
#include <iostream>

__global__ void hello(){

	printf("Hello world\n");
}


void query_device()
{
    int device_count = 0;
    cudaGetDeviceCount(&device_count);

    if(device_count == 0){
        std::cout<<"No CUDA capable device found"<<std::endl;
        return;
    }

    int device_no = 0;
    cudaDeviceProp iprop;
    cudaGetDeviceProperties(&iprop, device_no);

    std::cout<<"Device number: "<<device_no<<" property name: "<<iprop.name<<std::endl;
    std::cout<<"Number of multiprocessors: "<<iprop.multiProcessorCount<<std::endl;
    std::cout<<"Clock rate: "<<iprop.clockRate<<std::endl;
}

int main(){

query_device();

// wait until all threads execute
cudaDeviceSynchronize();

//reset the device
cudaDeviceReset();

return 0; 
}