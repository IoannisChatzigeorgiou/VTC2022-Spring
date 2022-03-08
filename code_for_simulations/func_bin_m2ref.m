function [rk, refM] = func_bin_m2ref(my_Matrix)
% -------------------------------------------------------------
% Convert a random binary matrix into row echelon form (ref)
% Syntax: 
% >> [rk, refM] = func_bin_m2ref(my_Matrix)
% where
% my_Matrix : (input) NxK random binary matrix
% rk        : (output) rank of the input matrix
% refM      : (output) binary matrix in row echelon form
% -------------------------------------------------------------
% Code developed by:
% Ioannis Chatzigeorgiou, Lancaster University, United Kingdom
% -------------------------------------------------------------
% Example:
% > A = randi([0 1], 5, 4)
% A =
%         0     0     1     0
%         0     1     0     0
%         1     1     1     1
%         0     1     0     1
%         0     0     1     0
% > [rk_A ref_A] = bin_m2ref(A)
% rk_A = 
%         4
% ref_A = 
%         1     1     1     1
%         0     1     0     0
%         0     0     1     0
%         0     0     0     1
%         0     0     0     0   
% -------------------------------------------------------------

matrix_rows = size(my_Matrix,1); 
matrix_cols = size(my_Matrix,2);

% If the matrix has more columns than rows then append all-zero rows
if matrix_cols > matrix_rows
    my_Matrix = [my_Matrix; zeros(matrix_cols-matrix_rows, matrix_cols)];
end

for current_col = 1:matrix_cols
    
    col_examined = 0;
    current_row  = 1;
    
    while (current_row <= matrix_rows) && ~col_examined
        
        if(my_Matrix(current_row,current_col)==1) && (sum(my_Matrix(current_row,1:current_col-1))==0)
            
            if current_row < current_col
            
                for xor_index = (current_row+1):matrix_rows
                    if(my_Matrix(xor_index,current_col) == 1)
                        my_Matrix(xor_index,:) = xor(my_Matrix(current_row,:),my_Matrix(xor_index,:));
                    end
                end                
                 
                temp = my_Matrix(current_col,:);
                my_Matrix(current_col,:) = my_Matrix(current_row,:);
                my_Matrix(current_row,:) = temp;

            else
            
                temp = my_Matrix(current_col,:);
                my_Matrix(current_col,:) = my_Matrix(current_row,:);
                my_Matrix(current_row,:) = temp;                
                
                for xor_index = (current_row+1):matrix_rows
                    if(my_Matrix(xor_index,current_col) == 1)
                        my_Matrix(xor_index,:) = xor(my_Matrix(current_col,:),my_Matrix(xor_index,:));
                    end
                end
                
            end
               
            col_examined = 1;
            
        else                        
            current_row = current_row + 1;
        end        
        
    end

end

%final_matrix
refM = my_Matrix;
if ~isscalar(sum(diag(refM)))   
    rk = 1;                  % return true
else
    rk = sum(diag(refM));    % return false
end

end