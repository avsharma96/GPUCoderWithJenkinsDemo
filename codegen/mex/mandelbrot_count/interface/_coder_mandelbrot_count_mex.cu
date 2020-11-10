//
//  _coder_mandelbrot_count_mex.cu
//
//  Code generation for function '_coder_mandelbrot_count_mex'
//


// Include files
#include "_coder_mandelbrot_count_mex.h"
#include "_coder_mandelbrot_count_api.h"
#include "mandelbrot_count.h"
#include "mandelbrot_count_data.h"
#include "mandelbrot_count_initialize.h"
#include "mandelbrot_count_terminate.h"

// Function Declarations
MEXFUNCTION_LINKAGE void mandelbrot_count_mexFunction(int32_T nlhs, mxArray
  *plhs[1], int32_T nrhs, const mxArray *prhs[3]);

// Function Definitions
void mandelbrot_count_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[3])
{
  const mxArray *outputs[1];

  // Check for proper number of arguments.
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 3, 4, 16, "mandelbrot_count");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 16,
                        "mandelbrot_count");
  }

  // Call the function.
  mandelbrot_count_api(prhs, nlhs, outputs);

  // Copy over outputs to the caller.
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&mandelbrot_count_atexit);

  // Module initialization.
  mandelbrot_count_initialize();

  // Dispatch the entry-point.
  mandelbrot_count_mexFunction(nlhs, plhs, nrhs, prhs);

  // Module termination.
  mandelbrot_count_terminate();
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

// End of code generation (_coder_mandelbrot_count_mex.cu)
