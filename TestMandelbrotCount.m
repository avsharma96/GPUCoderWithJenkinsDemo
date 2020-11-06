classdef TestMandelbrotCount < matlab.unittest.TestCase

    methods ( Test )
        
        function countDiff_WithinTolerance( testCase )
            load variables.mat
            tolerance = 1e+03;
            c1 = mandelbrot_count(maxIterations, xGrid, yGrid);
            
            diff = c1 - countCPU;
            error = sum(sum(diff.^2));
            
            disp(error)
            % Check if the coun difference exceeds the absolute tolerance
            testCase.verifyEqual( error, 0,'AbsTol',tolerance);

        end
    end
end