
#include <cuda.h">
#include <vector>

namespace cutils{

__device__ std::vector<int> get_thread_global_coords(){

	std::vector<int> ids(3, -1);
	ids[0] = blockIdx.x * blockDim.x + threadIdx.x ;
	ids[1] = blockIdx.y * blockDim.y + threadIdx.y ;
	ids[2] = blockIdx.z * blockDim.z + threadIdx.z ;
	return ids;

}

}
