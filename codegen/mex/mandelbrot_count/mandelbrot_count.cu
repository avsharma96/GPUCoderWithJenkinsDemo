//
//  mandelbrot_count.cu
//
//  Code generation for function 'mandelbrot_count'
//


// Include files
#include "mandelbrot_count.h"
#include "MWCudaDimUtility.hpp"
#include "_coder_mandelbrot_count_mex.h"
#include "rt_nonfinite.h"

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,// bFirstTime
  false,                               // bInitialized
  131594U,                             // fVersionInfo
  NULL,                                // fErrorFunction
  "mandelbrot_count",                  // fFunctionName
  NULL,                                // fRTCallStack
  false,                               // bDebugMode
  { 3194014219U, 53452778U, 2865749887U, 3590888462U },// fSigWrd
  NULL                                 // fSigMem
};

// Function Declarations
static real_T b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static real_T (*c_emlrt_marshallIn(const mxArray *xGrid, const char_T
  *identifier))[1000000];
static real_T (*d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[1000000];
static real_T e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static real_T emlrt_marshallIn(const mxArray *maxIterations, const char_T
  *identifier);
static const mxArray *emlrt_marshallOut(const real_T u[1000000]);
static real_T (*f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[1000000];
static __global__ void mandelbrot_count_kernel1(const real_T yGrid[1000000],
  const real_T xGrid[1000000], creal32_T z[1000000], real_T count[1000000],
  creal32_T z0[1000000]);
static __global__ void mandelbrot_count_kernel2(const creal32_T z0[1000000],
  real_T count[1000000], creal32_T z[1000000]);
static __global__ void mandelbrot_count_kernel3(real_T count[1000000]);
static __device__ real32_T rt_hypotf_snf(real32_T u0, real32_T u1);

// Function Definitions
static real_T b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = e_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*c_emlrt_marshallIn(const mxArray *xGrid, const char_T
  *identifier))[1000000]
{
  real_T (*y)[1000000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char *>(identifier);
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(emlrtAlias(xGrid), &thisId);
  emlrtDestroyArray(&xGrid);
  return y;
}
  static real_T (*d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *
  parentId))[1000000]
{
  real_T (*y)[1000000];
  y = f_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 0U,
    &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T emlrt_marshallIn(const mxArray *maxIterations, const char_T
  *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char *>(identifier);
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(maxIterations), &thisId);
  emlrtDestroyArray(&maxIterations);
  return y;
}

static const mxArray *emlrt_marshallOut(const real_T u[1000000])
{
  const mxArray *y;
  const mxArray *m;
  static const int32_T iv[2] = { 0, 0 };

  static const int32_T iv1[2] = { 1000, 1000 };

  y = NULL;
  m = emlrtCreateNumericArray(2, &iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m, *(int32_T (*)[2])&iv1[0], 2);
  emlrtAssign(&y, m);
  return y;
}

static real_T (*f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[1000000]
{
  real_T (*ret)[1000000];
  static const int32_T dims[2] = { 1000, 1000 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  ret = (real_T (*)[1000000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static __global__ __launch_bounds__(512, 1) void mandelbrot_count_kernel1(
  const real_T yGrid[1000000], const real_T xGrid[1000000], creal32_T z[1000000],
  real_T count[1000000], creal32_T z0[1000000])
{
  uint32_T threadId;
  int32_T k;
  threadId = static_cast<uint32_T>(mwGetGlobalThreadIndex());
  k = static_cast<int32_T>(threadId);
  if (k < 1000000) {
    real32_T re;

    //  Copyright 2016-2019 The MathWorks, Inc.
    //  Map computation to GPU.
    re = static_cast<real32_T>(xGrid[k] + 0.0 * yGrid[k]);
    z0[k].re = re;
    z0[k].im = static_cast<real32_T>(yGrid[k]);
    count[k] = 1.0;
    z[k].re = re;
    z[k].im = static_cast<real32_T>(yGrid[k]);
  }
}

static __global__ __launch_bounds__(512, 1) void mandelbrot_count_kernel2(const
  creal32_T z0[1000000], real_T count[1000000], creal32_T z[1000000])
{
  uint32_T threadId;
  int32_T k;
  threadId = static_cast<uint32_T>(mwGetGlobalThreadIndex());
  k = static_cast<int32_T>(threadId);
  if (k < 1000000) {
    real32_T re;
    real32_T im;
    re = (z[k].re * z[k].re - z[k].im * z[k].im) + z0[k].re;
    im = (z[k].re * z[k].im + z[k].im * z[k].re) + z0[k].im;
    z[k].re = re;
    z[k].im = im;
    count[k] += static_cast<real_T>(rt_hypotf_snf(re, im) <= 2.0F);
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

static __device__ real32_T rt_hypotf_snf(real32_T u0, real32_T u1)
{
  real32_T y;
  real32_T a;
  a = fabsf(u0);
  y = fabsf(u1);
  if (a < y) {
    a /= y;
    y *= sqrtf(a * a + 1.0F);
  } else if (a > y) {
    y /= a;
    y = a * sqrtf(y * y + 1.0F);
  } else {
    if (!static_cast<int32_T>(isnan(y))) {
      y = a * 1.41421354F;
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
  creal32_T (*gpu_z)[1000000];
  real_T (*gpu_count)[1000000];
  creal32_T (*gpu_z0)[1000000];
  cudaMalloc(&gpu_z0, 8000000ULL);
  cudaMalloc(&gpu_count, 8000000ULL);
  cudaMalloc(&gpu_z, 8000000ULL);
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

void mandelbrot_count_api(const mxArray * const prhs[3], int32_T, const mxArray *
  plhs[1])
{
  real_T (*count)[1000000];
  real_T maxIterations;
  real_T (*xGrid)[1000000];
  real_T (*yGrid)[1000000];
  count = (real_T (*)[1000000])mxMalloc(sizeof(real_T [1000000]));

  // Marshall function inputs
  maxIterations = emlrt_marshallIn(emlrtAliasP(prhs[0]), "maxIterations");
  xGrid = c_emlrt_marshallIn(emlrtAlias(prhs[1]), "xGrid");
  yGrid = c_emlrt_marshallIn(emlrtAlias(prhs[2]), "yGrid");

  // Invoke the target function
  mandelbrot_count(maxIterations, *xGrid, *yGrid, *count);

  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(*count);
}

void mandelbrot_count_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void mandelbrot_count_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2012b(emlrtRootTLSGlobal, "Distrib_Computing_Toolbox", 2);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void mandelbrot_count_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(false, emlrtRootTLSGlobal);
  }

  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

// End of code generation (mandelbrot_count.cu)
