#include <iostream>
#include <cuda.h>

#include "cuda_utils.h"


__global__ void hello(){

	auto t_ids = cutils::get_thread_global_coords();
	std::cout<<"x "<<t_ids[0]<<std::endl;
	std::cout<<"y "<<t_ids[1]<<std::endl;
	std::cout<<"z "<<t_ids[2]<<std::endl;
	
}

int main(){

hello<<1, 10>>();
cudaDeviceSynchronize();

return 0; 
}
