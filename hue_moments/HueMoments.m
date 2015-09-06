function [ f ] = HueMoments( image )
% HUEMOMENTS 
% Calculates the first 7 hue moments of given image.

% Image dimentions
[M, N] = size(image);

% m00
m00 = sum(sum(image));

% m10, m01
m10 = sum(sum(image .* repmat((1:M)', [1 N])));
m01 = sum(sum(image .* repmat(1:N, [M 1])));

% Xc, Yc
Xc = m10/m00;
Yc = m01/m00;

% mu02/20/11/03/30/12/21
mu02 = mu(0, 2, image, M, N, Xc, Yc);
mu20 = mu(2, 0, image, M, N, Xc, Yc);
mu11 = mu(1, 1, image, M, N, Xc, Yc);
mu03 = mu(0, 3, image, M, N, Xc, Yc);
mu30 = mu(3, 0, image, M, N, Xc, Yc);
mu12 = mu(1, 2, image, M, N, Xc, Yc);
mu21 = mu(2, 1, image, M, N, Xc, Yc);

% n02/20/11/03/30/12/21
n02 = n(0, 2, m00, mu02);
n20 = n(2, 0, m00, mu20);
n11 = n(1, 1, m00, mu11);
n03 = n(0, 3, m00, mu03);
n30 = n(3, 0, m00, mu30);
n12 = n(1, 2, m00, mu12);
n21 = n(2, 1, m00, mu21);

% f1/2/3/4/5/6/7
f(1) = n20 + n02;
f(2) = (n20 - n02)^2 + 4*(n11^2);
f(3) = (n30 - 3*n12)^2 + (3*n21 - n03)^2;
f(4) = (n30 + n12)^2 + (n21 + n03)^2;
f(5) = (n30 - 3*n12)*(n30 + n12)*((n30 + n12)^2 - 3*(n21 + n03)^2)+ (3*n21 - n03)*(n21 + n03)*(3*(n30 + n12)^2 - (n21 + n03)^2);
f(6) = (n20 - n02)*((n30 + n12)^2 - (n21 + n03)^2) + 4*n11*(n30 + n12)*(n21 + n03);
f(7) = (3*n21 - n03)*(n30 + n12)*((n30 + n12)^2 - 3*(n21 + n03)^2) + (n30 - 3*n12)*(n21 + n03)*((n21 + n03)^2 - 3*(n30 + n12)^2);

f = log(abs(f));

end

% Calculates mu_i,j
function [ value ] = mu(i, j, image, M, N, Xc, Yc)
	x = (repmat((1:M)', [1 N]) - repmat(Xc, [M N])) .^ i;
	y = (repmat(1:N, [M 1]) - repmat(Yc, [M N])) .^ j;
	value = sum(sum(image .* x .* y));
end

% Calculates n_i,j
function [ value ] = n(i, j, m00, muij)
    value = muij/(m00^((i+j)/2 + 1));           
end