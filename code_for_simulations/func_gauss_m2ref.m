function refM = func_gauss_m2ref(my_Matrix)
% -------------------------------------------------------------
% Convert a random binary matrix into row echelon form (ref)
% Syntax: 
% >> refM = func_gauss_m2ref(my_Matrix)
% where
% my_Matrix : (input) NxK random binary matrix for N<=K
% refM      : (output) binary matrix in row echelon form
% -------------------------------------------------------------
% Code developed by:
% Ioannis Chatzigeorgiou, Lancaster University, United Kingdom
% -------------------------------------------------------------
% Example:
% > A = randi([0 1], 3, 5)
% A =
%         1     0     1     1     1  
%         0     1     1     0     1
%         1     1     1     1     0
%
% > ref_A = func_gauss_m2ref(A)
% ref_A = 
%         1     1     1     1     0  
%         0     1     1     0     1
%         0     0     1     0     0  
%
% -------------------------------------------------------------

matrix_rows = size(my_Matrix,1); 
matrix_cols = size(my_Matrix,2);

% If the matrix has more columns than rows then append all-zero rows
if matrix_cols < matrix_rows
    error('The number of columns should be larger than or equal to the number of rows');
end

for current_col = 1:matrix_rows
% We are looking at the first matrix_rows of the matrix_cols and try
% to obtain an (matrix_rows x matrix_rows) identity matrix in the
% (matrix_rows x matrix_cols) matrix.
    
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

end