function [A] = specialMatrix(n,m)
% This function should return a matrix A as described in the problem statement
% Inputs n is the number of rows, and m the number of columns
A= zeros(n,m);
b= nargin('specialMatrix');
i=1;
j=1;
%This will make the user put in the correct number of elements%
if b~=2
    error('Missing two variables. Enter n for number of rows and m for number of columns')
end
        %First we need to make the first row of numbers equal to the column number%
for c=(1:m)
    %In this case, c is referring the the columns%
    for r = (1:n)
        %In this case, r is referring to row%
        if r == 1
            A(r,c) = i;
            i = i+1;
        end
        %We have now succesfully corresponded first row with number of
        %column%
        if c==1
            A(r,c) = j;
            j=j+1;
        end 
        %We now have sucessfully corresponded first column with number of roq%
        if c>= 2
            if r>=2
                A(r,c) = A(r,c-1) + A(r-1,c)
            end
        end
    end
end
% Things beyond here are outside of your function
