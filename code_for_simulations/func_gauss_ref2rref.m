function rrefM = func_gauss_ref2rref(my_Matrix)
% ---------------------------------------------------------------------
% Convert a matrix from row echelon form (ref) into 
% reduced row echelon form (rref)
% Syntax: 
% >> rrefM = func_gauss_ref2rref(my_Matrix)
% where
% my_Matrix : (input) NxK binary matrix in row echelon form, where N<=K
% ---------------------------------------------------------------------
% Code developed by:
% Ioannis Chatzigeorgiou, Lancaster University, United Kingdom
% ---------------------------------------------------------------------

matrix_rows = size(my_Matrix,1); 
rrefM = my_Matrix;

% if the matrix consists of rows that contain pivots, then proceed
if matrix_rows > 1

    for current_row = matrix_rows:-1:2
    
        % idenity the column where the pivot of the current row is located
        col_examined = find(rrefM(current_row, :), 1);
        
        % XOR the current row with a row above the current row only if
        % the entry of the examined column of that row is non-zero
        for i = (current_row-1):-1:1
           
            if rrefM(i, col_examined) == 1                
                rrefM(i, :) = xor(rrefM(i, :), rrefM(current_row, :));            
            end           
            
        end       
        
    end
         
end
    
end