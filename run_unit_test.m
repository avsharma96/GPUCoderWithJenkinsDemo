%% Create configuration object of class 'coder.gpuConfig'.
disp('Generating MEX file...')
cfg = coder.gpuConfig('mex');
cfg.GpuConfig.CompilerFlags = '--fmad=false';
cfg.FilePartitionMethod = 'SingleFile';
cfg.GenerateReport = true;
cfg.ReportPotentialDifferences = false;

%% Define argument types for entry-point 'addWithType'.
ARGS = cell(1);
ARGS{1} = cell(1,2);
ARGS{1}{1} = coder.typeof(0);
ARGS{1}{2} = coder.typeof(0);

%% Invoke GPU Coder.
codegen -config cfg addWithType -args ARGS{1}
%% Run the unit tests using the generated MEX file
coder.runTest('TestAddWithType', 'addWithType');