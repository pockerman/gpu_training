#include <iostream>
#include <cuda.h>

#define N 64


// Kernel definition
__global__ void mat_addition(float* A[N], float* B[N],
                             float* C[N])
{
    int i = threadIdx.x;
    int j = threadIdx.y;
    C[i][j] = A[i][j] + B[i][j];
}


int main(){

const int N_ROWS = 64;
const int N_COLS = 64;

float hA[N][N];
float hB[N][N];
float hC[N][N];

for(int r=0; r<N; ++r){
  for(int c=0; c<N; ++c){
  
  	if (r == c){
  		hA[r][c] = r+c;
  		hB[r][c] = r+c;
  	}
  	else{
  		hA[r][c] = 0.0;
  		hB[r][c] = 0.0;
  	}
  	
  	hC[r][c] = 0.0;	 
  }
}


float* dA[N];
float* dB[N];
float* dC[N]; 

// allocate memory on the device

cudaMalloc((void**)&dA, (N*N)*sizeof(float));
cudaMalloc((void**)&dB, (N*N)*sizeof(float));
cudaMalloc((void**)&dC, (N*N)*sizeof(float));

cudaMemcpy(dA, hA, (N*N)*sizeof(float), cudaMemcpyHostToDevice);
cudaMemcpy(dB, hB, (N*N)*sizeof(float), cudaMemcpyHostToDevice);
cudaMemcpy(dC, hC, (N*N)*sizeof(float), cudaMemcpyHostToDevice);

int numBlocks = 1;
dim3 threadsPerBlock(N, N);
mat_addition<<<numBlocks,threadsPerBlock>>>(dA, dB, dC);

cudaMemcpy(hC, dC, (N*N)*sizeof(float), cudaMemcpyDeviceToHost);

cudaFree(dA); 
cudaFree(dB); 
cudaFree(dC);

return 0;
}


