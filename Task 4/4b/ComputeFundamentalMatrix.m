function [F] = ComputeFundamentalMatrix(x1, x2)
    A = zeros(20, 9);
    A(:, 1) = x1(:, 1).*x2(:, 1);
    A(:, 2) = x1(:, 2).*x2(:, 1);
    A(:, 3) = x2(:, 1);
    A(:, 4) = x1(:, 1).*x2(:, 2);
    A(:, 5) = x1(:, 2).*x2(:, 2);
    A(:, 6) = x2(:, 2);
    A(:, 7) = x1(:, 1);
    A(:, 8) = x1(:, 2);
    A(:, 9) = ones(20, 1);
%     
%     [U,S,V] = svd(A);% 
%     F = V(:,9) ./ V(9,9);
%     F = reshape(F, [3,3]);


    [~, ~, v] = svd(A);
    f = v(:, end);
    F = transpose(reshape(f, [3, 3])); % 3x3

    SVD Clean up
    [u, d, v] = svd(F);
    d(3,3) = 0;
    F = u*d*v';
end