function myHuffman(img,i)
%main method!
    N=ndims(img);
    if i=='h'
        if N==2 %1 channel image
            originalSize = length(twodto1d(img))*8; %assuming uint8 format
            newimg = Huff(img,0);
            %i believe i got the formula from lecture 7.
            compressionRatio = originalSize / newimg;
            disp('The compression ratio is:');
            disp(compressionRatio);
        else
            if N==3 %rgb image with 3 channels
                [m,n,~] = size(img);
                %defining the channels
                c1 = zeros(m*n,1);
                c2 = zeros(m*n,1);
                c3 = zeros(m*n,1);
                p=1;
                for l=1:m
                    for j=1:n
                        %populating the channels
                                c1(p) = img(l,j,1);
                                c2(p) = img(l,j,2);
                                c3(p) = img(l,j,3);
                                p=p+1;
                    end
                end
                %encoding the channels
                channel1 = Huff(c1,1);
                channel2 = Huff(c2,2);
                channel3 = Huff(c3,3);
                originalSize = length(twodto1d(c1))*24;
                %compression ratio for the image
                compressionRatio = originalSize / (channel1 + channel2 + channel3);
                disp('The compression ratio is:');
                disp(compressionRatio);
            end
        end
    end
    %please refer to the comments above for the below code, it's literally
    %the same.
    if i =='t'
        %k is the number of pixels before truncation. refer to lecture 6
        %for more info.
        k=input('Please enter the value of K for Truncated Huffman, notice it has to be smaller than the number of different symbols in the image.');
        if N==2
            originalSize = length(twodto1d(img))*8; %assuming uint8 format
            newimg = THuff(img, 0, k);
            compressionRatio = originalSize / newimg;
            disp('The compression ratio is:');
            disp(compressionRatio);
        else
            if N==3
                [m,n,~] = size(img);
                c1 = zeros(m*n,1);
                c2 = zeros(m*n,1);
                c3 = zeros(m*n,1);
                p=1;
            for l=1:m
                for j=1:n
                        c1(p) = img(l,j,1);
                        c2(p) = img(l,j,2);
                        c3(p) = img(l,j,3);
                        p=p+1;
                end
            end
            channel1 = THuff(c1, 1, k);
            channel2 = THuff(c2, 2, k);
            channel3 = THuff(c3, 3, k);
            originalSize = length(twodto1d(c1))*24;
            compressionRatio = originalSize / (channel1 + channel2 + channel3);
            disp('The compression ratio is:');
            disp(compressionRatio);
            end
        end
    end
    if i == 's'
        %sorry but blocksize is a static 32.
        if N==2
            originalSize = length(twodto1d(img))*8; %assuming uint8 format
            newimg = SHuff(img,0);
            compressionRatio = originalSize / newimg;
            disp('The compression ratio is:');
            disp(compressionRatio);
        else
            [m,n,~] = size(img);
            c1 = zeros(m*n,1);
            c2 = zeros(m*n,1);
            c3 = zeros(m*n,1);
            p=1;
            for l=1:m
                for j=1:n
                    c1(p) = img(l,j,1);
                    c2(p) = img(l,j,2);
                    c3(p) = img(l,j,3);
                    p=p+1;
                end
            end
            channel1 = SHuff(c1,1);
            channel2 = SHuff(c2,2);
            channel3 = SHuff(c3,3);
            originalSize = length(twodto1d(c1))*24;
            compressionRatio = originalSize / (channel1 + channel2 + channel3);
            disp('The compression ratio is:');
            disp(compressionRatio);
        end
    end
end