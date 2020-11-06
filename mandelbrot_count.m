function count = mandelbrot_count(maxIterations, xGrid, yGrid) %#codegen

% Copyright 2016-2019 The MathWorks, Inc. 

z0 = addWithType(xGrid, 1i*yGrid);
count = ones(size(z0));

% Map computation to GPU.
coder.gpu.kernelfun;

z = z0;
for n = 0:maxIterations
    z = addWithType(z.*z, z0);
    inside = abs(z)<=2;
    count = count + inside;
end

count = log(count);
