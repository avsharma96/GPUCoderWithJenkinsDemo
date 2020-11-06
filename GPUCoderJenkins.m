
%% GPU Code Generation: The Mandelbrot Set
%
% This example shows how to generate CUDA(R) code from a simple MATLAB(R)
% function by using GPU Coder(TM). A Mandelbrot set implementation by using 
% standard MATLAB commands acts as the entry-point function. This example
% uses the |codegen| command to generate a MEX function that runs on the
% GPU. You can run the MEX function to check for run-time errors.   

% Copyright 2016-2019 The MathWorks, Inc. 


%% Prerequisites
% * CUDA enabled NVIDIA(R) GPU with compute capability 3.2 or higher.
% * NVIDIA CUDA toolkit and driver. 
% * Environment variables for the compilers and libraries. For information 
% on the supported versions of the compilers and libraries, see 
% <docid:gpucoder_gs#mw_aa8b0a39-45ea-4295-b244-52d6e6907bff
% Third-Party Products>. For setting up the environment variables, see 
% <docid:gpucoder_gs#mw_453fbbd7-fd08-44a8-9113-a132ed383275
% Environment Variables>.

%% Verify GPU Environment
% To verify that the compilers and libraries necessary for running this example
% are set up correctly, use the <docid:gpucoder_ref#mw_0957d820-192f-400a-8045-0bb746a75278 coder.checkGpuInstall>
% function.
envCfg = coder.gpuEnvConfig('host');
envCfg.BasicCodegen = 1;
envCfg.Quiet = 1;
coder.checkGpuInstall(envCfg);

%% Mandelbrot Set
% The Mandelbrot set is the region in the complex plane consisting of the 
% values $z_0$ for which the trajectories defined by
%
% $$z_{k+1} = {z_k}^2 + z_0, k = 0,1,...$$
%
% remain bounded at $k\rightarrow\infty$. The overall geometry of the 
% Mandelbrot set is shown in the figure. This view does not have the 
% resolution to show the richly detailed structure of the fringe just 
% outside the boundary of the set.
%
% <<../mandelbrotSet.png>> 
%

%% Define Input Regions
% Pick a set of limits that specify a highly zoomed part
% of the Mandelbrot set in the valley between the main cardioid and the 
% $p/q$ bulb to its left. A |1000x1000| grid of $Re\{x\}$ and $Im\{y\}$ is 
% created between these two limits. The Mandelbrot algorithm is then 
% iterated at each grid location. An iteration number of 500 is enough to 
% render the image in full resolution.
maxIterations = 500;
gridSize = 1000;
xlim = [-0.748766713922161, -0.748766707771757];
ylim = [ 0.123640844894862,  0.123640851045266];

x = linspace( xlim(1), xlim(2), gridSize );
y = linspace( ylim(1), ylim(2), gridSize );
[xGrid,yGrid] = meshgrid( x, y );

%% The Mandelbrot Entry-Point Function
% The
% <matlab:edit(fullfile(matlabroot,'examples','gpucoder','main','mandelbrot_count.m'))
% mandelbrot_count.m> entry-point function contains a vectorized implementation of the
% Mandelbrot set based on the code provided in the e-book 
% <https://www.mathworks.com/moler/exm _Experiments in MATLAB_> by Cleve Moler. The
% %#codegen directive turns on MATLAB for code generation error checking.
% When GPU Coder encounters the |coder.gpu.kernelfun| pragma, it 
% attempts to parallelize all the computation within this function, and then 
% maps it to the GPU.
type mandelbrot_count

%% Test the Functionality of |mandelbrot_count|
% Run the |mandelbrot_count| function with the xGrid, yGrid values that 
% were previously generated, and then plot the results.
countCPU = mandelbrot_count(maxIterations, xGrid, yGrid);
save variables.mat
figure(2), imagesc( x, y, countCPU);
colormap( [jet();flipud( jet() );0 0 0] );
title('Mandelbrot Set on MATLAB');
axis off

%% Generate CUDA MEX for the Function
% To generate CUDA MEX for the |mandelbrot_count| function, create a GPU 
% code configuration object and run the <docid:coder_ref#br46oyi-1 codegen>
% command. Because of architectural differences between the CPU and GPU, 
% numeric verification does not always match. This scenario is true when 
% using the single data type in your MATLAB code and performing 
% accumulation operations on these single data type values. Like this 
% Mandelbrot example even the double data types cause numeric errors. 
% One reason for this mismatch is that the GPU floating-point units use 
% fused Floating-point Multiply-Add (FMAD) instructions and the CPU does 
% not use these instructions. The |fmad=false| option that is passed to the
% |nvcc| compiler turns off this FMAD optimization.
cfg = coder.gpuConfig('mex');
cfg.GpuConfig.CompilerFlags = '--fmad=false';
codegen -config cfg -args {maxIterations,xGrid,yGrid} mandelbrot_count

%% Run the MEX Function
% After you generate a MEX function, you can verify that it has the same 
% functionality as the original MATLAB entry-point function. Run the 
% generated |mandelbrot_count_mex| and plot the results.
countGPU = mandelbrot_count_mex(maxIterations, xGrid, yGrid);

figure(2), imagesc( x, y, countGPU );
colormap( [jet();flipud( jet() );0 0 0] );
title('Mandelbrot Set on GPU');
axis off

%% Conclusion
% CUDA code was generated for a simple MATLAB function 
% implementing the Mandelbrot set. Implementation was accomplished by using 
% the |coder.gpu.kernelfun| pragma and invoking the |codegen| command to 
% generate MEX function. Additional compiler flags, FMAD=false, was 
% passed to the |nvcc| compiler to disable the FMAD 
% optimization that the NVIDIA compilers performed. 
