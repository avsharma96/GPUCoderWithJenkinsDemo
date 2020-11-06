%% Run Integration Test in MATLAB
load variables.mat

%% Create configuration object of class 'coder.MexCodeConfig'.
cfg = coder.gpuConfig('mex');
cfg.GpuConfig.CompilerFlags = '--fmad=false';
cfg.FilePartitionMethod = 'SingleFile';
cfg.GenerateReport = true;
cfg.ReportPotentialDifferences = false;

%% Invoke GPU Coder.
codegen -config cfg -args {maxIterations,xGrid,yGrid} mandelbrot_count

%% Run the unit tests using the generated MEX file
coder.runTest('TestMandelbrotCount', 'mandelbrot_count');