function [L, U, P] = luFactor(A)
[rows, columns] = size(A);
P = eye(rows);
L= eye(columns);
U = A;
%Check number of arguments%
if nargin ~= 1
    error('Bro only one matirx pls');
elseif size(A,1) ~= size(A,2)
    error ('Bro u need a square matirx pls')
end


for i= 1:rows
    %Pivot Matrix%
    %make max output only location%
    %find max in first row%
    [~, loc] = max(abs(U(i:rows, i)));
    loc= loc+i-1;
    if loc ~= i
        U([loc,i],:)=U([i,loc],:);
        P([loc,i],:)=P([i,loc],:);
        if i>=2
            L([loc,i],1:i-1)=L([i,loc], 1:i-1);
        end
    end
    %Gauss Elimination%
    for j = i+1:rows
        coeff=U(j,i)/U(i,i);
        temp_new= coeff.*U(i,:);
        U(j,:)= U(j,:) - temp_new;
        L(j,i) = coeff;        
    end
end
