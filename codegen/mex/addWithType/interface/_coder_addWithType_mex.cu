//
//  _coder_addWithType_mex.cu
//
//  Code generation for function '_coder_addWithType_mex'
//


// Include files
#include "_coder_addWithType_mex.h"
#include "addWithType.h"

// Function Declarations
MEXFUNCTION_LINKAGE void addWithType_mexFunction(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[2]);

// Function Definitions
void addWithType_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs, const
  mxArray *prhs[2])
{
  const mxArray *outputs[1];

  // Check for proper number of arguments.
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 2, 4, 11, "addWithType");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 11,
                        "addWithType");
  }

  // Call the function.
  addWithType_api(prhs, nlhs, outputs);

  // Copy over outputs to the caller.
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&addWithType_atexit);

  // Module initialization.
  addWithType_initialize();

  // Dispatch the entry-point.
  addWithType_mexFunction(nlhs, plhs, nrhs, prhs);

  // Module termination.
  addWithType_terminate();
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

// End of code generation (_coder_addWithType_mex.cu)
