classdef TestAddWithType < matlab.unittest.TestCase
    
    methods ( Test )
        
        function verifyTypeMatch( testCase )
            x = 1;
            y = 2;
            z = addWithType(x, y);
            outputIsSingle = isa( z , 'single' );
            outputIsDouble = isa( z , 'double' );
            testCase.verifyTrue( outputIsSingle | outputIsDouble);
        end
        
        function addWitheps( testCase )
            x = eps(5);
            y = 2;
            z = addWithType(x,y);
            if isa( z , 'single' ) == true
                t = single(eps(5) + 2);
            elseif isa ( z , 'double' ) == true
                t = double(eps(5) + 2);
            else
                t = 0;
            end
            testCase.verifyEqual(z , t );
        end
    end
end