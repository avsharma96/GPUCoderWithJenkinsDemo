//
//  addWithType.h
//
//  Code generation for function 'addWithType'
//


#pragma once

// Include files
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "addWithType_types.h"

// Custom Header Code
#ifdef __CUDA_ARCH__
#undef printf
#endif

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
CODEGEN_EXPORT_SYM real_T addWithType(real_T a, real_T b);
void addWithType_api(const mxArray * const prhs[2], int32_T nlhs, const mxArray *
                     plhs[1]);
CODEGEN_EXPORT_SYM void addWithType_atexit();
CODEGEN_EXPORT_SYM void addWithType_initialize();
CODEGEN_EXPORT_SYM void addWithType_terminate();

// End of code generation (addWithType.h)
