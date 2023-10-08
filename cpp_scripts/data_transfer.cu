#include <iostream>
#include <cuda.h>
#include <stdio.h>


__global__ void access_data(int* input){
    int gid = blockIdx.x * blockDim.x + threadIdx.x;
    printf("tid: %d, gid: %d, value: %d \n", threadIdx.x, gid, input[gid]);
}


int main(){

    int size = 128;
    int byte_size = size * sizeof(int);

    int* h_input = (int*)malloc(byte_size);

    // initialize the input
    for(int i=0; i<size; ++i){
        h_input[i] = i;
    }

    // need memory allocated in the device
    // also
    int* d_input;

    cudaMalloc((void**)& d_input, byte_size);

    // now transfer the data to the device
    cudaMemcpy(d_input, h_input, 
    byte_size, cudaMemcpyHostToDevice);

    dim3 block(64);
    dim3 grid(2);

    access_data<<<grid, block>>>(d_input);
    cudaDeviceSynchronize();


    // reclaim the memory
    cudaFree(d_input);
    free(h_input);

    cudaDeviceReset();
    return 0;

}