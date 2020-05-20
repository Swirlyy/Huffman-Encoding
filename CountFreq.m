function count = CountFreq(P)
%give it a 1d array and it will count the number of occurnces of each
%value.
m = length(P);
count = zeros(1,256);
for j = 1:m
    count(P(j) + 1) = count(P(j)+1)+1;
end
    count(count == 0) = [];
end