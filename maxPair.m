function A = maxPair(I)
A=[];
m=[];
for i = 1:1:length(I)-1
    m=[I(i),I(i+1)];
    if sum(m) > sum(A)
        A=m;
    end
end
end
%didnt even need this one :'D