//
//  mandelbrot_count.cu
//
//  Code generation for function 'mandelbrot_count'
//


// Include files
#include "mandelbrot_count.h"
#include "MWCudaDimUtility.hpp"
#include "rt_nonfinite.h"

// Function Declarations
static __global__ void mandelbrot_count_kernel1(const real_T yGrid[1000000],
  const real_T xGrid[1000000], creal_T z[1000000], real_T count[1000000],
  creal_T z0[1000000]);
static __global__ void mandelbrot_count_kernel2(const creal_T z0[1000000],
  real_T count[1000000], creal_T z[1000000]);
static __global__ void mandelbrot_count_kernel3(real_T count[1000000]);
static __device__ real_T rt_hypotd_snf(real_T u0, real_T u1);

// Function Definitions
static __global__ __launch_bounds__(512, 1) void mandelbrot_count_kernel1(const
  real_T yGrid[1000000], const real_T xGrid[1000000], creal_T z[1000000], real_T
  count[1000000], creal_T z0[1000000])
{
  uint32_T threadId;
  int32_T k;
  threadId = static_cast<uint32_T>(mwGetGlobalThreadIndex());
  k = static_cast<int32_T>(threadId);
  if (k < 1000000) {
    real_T re;

    //  Copyright 2016-2019 The MathWorks, Inc.
    //  Map computation to GPU.
    re = xGrid[k] + 0.0 * yGrid[k];
    z0[k].re = re;
    z0[k].im = yGrid[k];
    count[k] = 1.0;
    z[k].re = re;
    z[k].im = yGrid[k];
  }
}

static __global__ __launch_bounds__(512, 1) void mandelbrot_count_kernel2(const
  creal_T z0[1000000], real_T count[1000000], creal_T z[1000000])
{
  uint32_T threadId;
  int32_T k;
  threadId = static_cast<uint32_T>(mwGetGlobalThreadIndex());
  k = static_cast<int32_T>(threadId);
  if (k < 1000000) {
    real_T re;
    real_T im;
    re = (z[k].re * z[k].re - z[k].im * z[k].im) + z0[k].re;
    im = (z[k].re * z[k].im + z[k].im * z[k].re) + z0[k].im;
    z[k].re = re;
    z[k].im = im;
    count[k] += static_cast<real_T>(rt_hypotd_snf(re, im) <= 2.0);
  }
}

static __global__ __launch_bounds__(512, 1) void mandelbrot_count_kernel3(real_T
  count[1000000])
{
  uint32_T threadId;
  int32_T k;
  threadId = static_cast<uint32_T>(mwGetGlobalThreadIndex());
  k = static_cast<int32_T>(threadId);
  if (k < 1000000) {
    count[k] = log(count[k]);
  }
}

static __device__ real_T rt_hypotd_snf(real_T u0, real_T u1)
{
  real_T y;
  real_T a;
  a = fabs(u0);
  y = fabs(u1);
  if (a < y) {
    a /= y;
    y *= sqrt(a * a + 1.0);
  } else if (a > y) {
    y /= a;
    y = a * sqrt(y * y + 1.0);
  } else {
    if (!static_cast<int32_T>(isnan(y))) {
      y = a * 1.4142135623730951;
    }
  }

  return y;
}

void mandelbrot_count(real_T maxIterations, const real_T xGrid[1000000], const
                      real_T yGrid[1000000], real_T count[1000000])
{
  int32_T i;
  real_T (*gpu_yGrid)[1000000];
  real_T (*gpu_xGrid)[1000000];
  creal_T (*gpu_z)[1000000];
  real_T (*gpu_count)[1000000];
  creal_T (*gpu_z0)[1000000];
  cudaMalloc(&gpu_z0, 16000000ULL);
  cudaMalloc(&gpu_count, 8000000ULL);
  cudaMalloc(&gpu_z, 16000000ULL);
  cudaMalloc(&gpu_xGrid, 8000000ULL);
  cudaMalloc(&gpu_yGrid, 8000000ULL);

  //  Copyright 2016-2019 The MathWorks, Inc.
  //  Map computation to GPU.
  cudaMemcpy(gpu_yGrid, (void *)&yGrid[0], 8000000ULL, cudaMemcpyHostToDevice);
  cudaMemcpy(gpu_xGrid, (void *)&xGrid[0], 8000000ULL, cudaMemcpyHostToDevice);
  mandelbrot_count_kernel1<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (*gpu_yGrid, *gpu_xGrid, *gpu_z, *gpu_count, *gpu_z0);
  i = static_cast<int32_T>(maxIterations + 1.0);
  for (int32_T n = 0; n < i; n++) {
    mandelbrot_count_kernel2<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (*gpu_z0, *gpu_count, *gpu_z);
  }

  mandelbrot_count_kernel3<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (*gpu_count);
  cudaMemcpy(&count[0], gpu_count, 8000000ULL, cudaMemcpyDeviceToHost);
  cudaFree(*gpu_yGrid);
  cudaFree(*gpu_xGrid);
  cudaFree(*gpu_z);
  cudaFree(*gpu_count);
  cudaFree(*gpu_z0);
}

// End of code generation (mandelbrot_count.cu)
