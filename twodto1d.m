function A = twodto1d(I)
%give it a 2d array(1 channel of an image, for example) and it will return
%the same array but in a 1d format
%example: [1,2,3
%          4,5,6]
%will be: [1,2,3,4,5,6]
[m,n] = size(I);
P = zeros(1, m * n);
    counter = 1;
        for i = 1:m
            for j = 1:n
                P(counter) = I(i,j);
                counter = counter+1;
            end
        end
        A=P;
end