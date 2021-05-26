#include <iostream>
#include <cuda.h>

__global__ void square(float* d_out, float* d_in){

// the thread id
int idx = threadIdx.x;
float f = d_in[idx];
d_out[idx] = f * f;

}

int main(int argc, char** argv){
const int ARRAY_SIZE = 64;
const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

// generate input array on the host
float h_int[ARRAY_SIZE];
for(int i=0; i<ARRAY_SIZE; ++i){
   h_in[i] = float(i);
}

float h_out[ARRAY_SIZE];

float* d_in = NULL;
float* d_out = NULL;

// allocate GPU memory
cudaMalloc((void **) &d_in, ARRAY_BYTES);
cudaMalloc((void **) &d_out, ARRAY_BYTES);

// transfer array to GPU 
cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);

// launch kernel
square<<<1, ARRAY_SIZE>>>(d_out, d_in);

cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);


for(int i=0; i<ARRAY_SIZE; ++i){
	std::cout<<h_in[i]<<", "<<h_out[i]<<std::endl;
}

// free memory
cudaFree(d_in);
cudaFree(d_out);


return 0;
}
