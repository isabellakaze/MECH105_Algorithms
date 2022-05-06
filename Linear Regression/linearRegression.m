function [fX, fY, slope, intercept, Rsquared] = linearRegression(x,y)
%Isabella Kaze
%linearRegression Computes the linear regression of a data set
%   Compute the linear regression based on inputs:
%     1. x: x-values for our data set
%     2. y: y-values for our data set

%-------------START OF ERROR CHECKS-----------------%

%Tells us how many rows each input has%
independent_rows = size(x,1);
dependent_rows = size(y,1);
%Expectation for number of rows in x and y is 1%

%Checks if x is only one rows just incase they messed up the x matrix%
if independent_rows~=1 ||dependent_rows~=1
    error('There should only be one row for x and y inputs for Linear regression.')
end

%Tells us number of points in each array%
independent_length= length(x);%y_pts
dependent_length = length(y);
%We need these to compare sizes of the arrays to make sure they match%

%Compares sizes of dependent and independent variables%
if independent_length ~= dependent_length
    error('Lengths of inputs do not match. Fix pls!')
end

%----------END OF ERROR CHECKS-----------%

%~~~~~~~~~~~~SORT DATA FROM LEAST TO GREATEST~~~~~~~~~~~%
%First we sort data from least to greatest for our dependent variables%
%This code was given%

[sortedY, sortOrder] = sort(y);
sortedX = x(sortOrder);

%Reassign arrays based on the sorting that was required%
independent_array = sortedX;
dependent_array = sortedY;

%~~~~~~~~~~~~DETERMINE IF THERE ARE OUTLIERS~~~~~~~~~~%

%First we need our quartile ranges%

%Start with quartile index%
q1_index = floor((dependent_length+1)/4);
q3_index = floor((3*dependent_length +3)/4);

%Now use index to create q1 and q3 values%
q1 = dependent_array(q1_index);
q3 = dependent_array(q3_index);

%Compute IQR%
iqr= q3-q1;

%Check for outliers%

%IQR check point%
q1_iqr_check = q1 - (1.5 * iqr);
q3_iqr_check = q3 + (1.5*iqr);

%Check each data point to see if they are an outlier%
outlier_checker = logical(ones(1, dependent_length));
for i=1:dependent_length
    if dependent_array(i)< q1_iqr_check || dependent_array(i)> q3_iqr_check
        outlier_checker(i) = 0;
    end
end

fX=independent_array(outlier_checker);
fY=dependent_array(outlier_checker);

fY_length = length(fY)
fX_length = length(fX)

%----------END OF OUTLIER CHECK------------%

%-----------MAKE LINEAR REGRESSION LINE-----%

%First calculate a_1%

%Sum of corresponding x values multiplied by corresponding y values%
sum_xy = 0;
for i=1:fY_length
    product_xy = fY(i)*fX(i);
    sum_xy = sum_xy + product_xy;
end

%Sum of x times sum of y%
sum_x_sum_y = sum(fX)* sum(fY);

%Sum of each x values squared%
sum_square_x = 0;
for i=1:fX_length
    square_x = fX(i) * fX(i);
    sum_square_x = sum_square_x + square_x;
end

%Sum of x and then square it%
square_sum_x = (sum(fX))^2;

%Calculate a1 aka slope%
slope= (fY_length*sum_xy - sum_x_sum_y)/(fY_length*sum_square_x - square_sum_x);


%Next calculate a0 aka intercept%
fY_mean = (1/fY_length)*(sum(fY));
fX_mean = (1/fX_length)*(sum(fX));
intercept = fY_mean - slope*fX_mean;

%-----------CALCULATE R^2---------%

%First calculate Sr%
Sr= 0;
for i=1:fY_length
    Sr_garbage = (fY(i)-intercept-slope*fX(i))^2;
    Sr = Sr + Sr_garbage;
end

%Now Calculate St&
St= 0;
for i=1:fY_length
    St_garbage = (fY(i) - fY_mean)^2;
    St = St + St_garbage;
end

Rsquared = (St-Sr)/St;
%   Outputs:
%     1. fX: x-values with outliers removed
%     2. fY: y-values with outliers removed
%     3. slope: slope from the linear regression y=mx+b
%     4. intercept: intercept from the linear regression y=mx+b
%     5. Rsquared: R^2, a.k.a. coefficient of determination


end
