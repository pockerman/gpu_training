
#include <cuda.h>
#include <vector>

namespace cutils{

__device__ int get_thread_global_coords_x(){

	return  blockIdx.x * blockDim.x + threadIdx.x ;
}

__device__ int get_thread_global_coords_y(){

	return blockIdx.y * blockDim.y + threadIdx.y ;
}

__device__ int get_thread_global_coords_z(){

        return blockIdx.z * blockDim.z + threadIdx.z ;
}

}
