function [I] = Simpson(x, y)
% Numerical evaluation of integral by Simpson's 1/3 Rule
% Inputs
%   x = the vector of equally spaced independent variable
%   y = the vector of function values with respect to x
% Outputs:
%   I = the numerical integral calculated

%START OF ERROR CHECKS%

%Tells us how many rows each input has%
independent_rows = size(x,1);
dependent_rows = size(y,1);
%Expectation for number of rows in x and y is 1%

%Checks if x is only one rows just incase they messed up the x matrix%
if independent_rows~=1 ||dependent_rows~=1
    error('There should only be one row for x and y inputs for Simpson Rule. Idk how to interpret ur data bro.')
end

%Tells us number of points in each array%
independent= length(x);%y_pts
dependent = length(y);
%We need these to compare sizes of the arrays to make sure they match%

num_seg= independent-1;

%Step Size%
h= x(independent) - x(1);

%Compares sizes of dependent and independent variables%
if independent ~= dependent
    error('Lengths of inputs do not match. Fix pls!')
end

%We also need to make sure we have at least two points%
if independent<2
    error('We need at least two point to make an estimate. Pls check ur input')
end
%Two points and up allows us to either use trap rule or Simpson's 1/3
%algorithm%

%Check if evenly spaced%
if range(x(2:end)-x(1:end-1))~=0
    error('No even space')
end
 

% END OF ERROR CHECK %


%BEGINNING OF SIMPSONS 1/3 ALGORITHM%


%Use trapazoid if we only have two points%
if independent == 2
    warning('We use trap on last two point')
    I= h*((y(1)+y(2))/2);

    %We are now going to use simpson if we do not need to use trap at the end%

    %This is for n being even, aka number of points being odd%
elseif rem(independent,2)~=0

    % Since MATLAB index array starts at 1, the "even" x sub values are
    % indexed as odd in MATLAB%
    %ie. x0 would be indexed as one%
    %if we want to address x sub even values, we need to address
    %odd-indexed elements%

    %even fx sub values but odd indexed values in dependent array%
    
    %Special case for three arguments%
    if dependent==3
        even_fx_sub=0;
        odd_fx_sub=y(2);
    else
    even_fx_sub = y(3:2:dependent-1);
    odd_fx_sub = y(2:2:dependent-2);
    end
    
    %Composite us fo simpson 1/3%
    I = (h/(3*num_seg))*(y(1) + (4*sum(odd_fx_sub)) + (2*sum(even_fx_sub))+y(dependent));

    %Case where we must use simpsons and trap rule at the end becuase the number of segements is even%
elseif rem(independent,2)==0
    warning('We use trap rule at end')

    %Our even indexed points are fine, we just need to edit ending sims point because we are using the second to last point%

    even_fx_sub = y(3:2:dependent-1);

    %excludes last point that would not fit into segmentation using simpson
    %rule%
    odd_fx_sub = y(2:2:dependent-2);
    
    %Uses simpsons rule up until we need trap for last two points%
    I = (h/(3*num_seg))*(y(1) + (4*sum(odd_fx_sub)) + (2*sum(even_fx_sub))+y(dependent-1));

    %Adds simpson integral to last trap at the end%
    h_trap = x(independent)-x(independent-1);
    I= I + ((h_trap/2)*(y(dependent)+y(dependent-1)));
    
end