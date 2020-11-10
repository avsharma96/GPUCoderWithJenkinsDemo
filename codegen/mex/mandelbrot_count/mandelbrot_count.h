//
//  mandelbrot_count.h
//
//  Code generation for function 'mandelbrot_count'
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
#include "mandelbrot_count_types.h"

// Custom Header Code
#ifdef __CUDA_ARCH__
#undef printf
#endif

// Function Declarations
CODEGEN_EXPORT_SYM void mandelbrot_count(real_T maxIterations, const real_T
  xGrid[1000000], const real_T yGrid[1000000], real_T count[1000000]);

// End of code generation (mandelbrot_count.h)
