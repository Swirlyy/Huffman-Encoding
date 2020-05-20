function A = SHuff(img,channelnum)
    disp('begin');
    disp(datestr(now,'HH:MM:SS.FFF'));
    %Transforms the image/channel to a 1D array
    P = twodto1d(img);
    %counts the number of times each pixel value was repeated.
    count = CountFreq(P);
    %my new data type check myNode.m for info
    nodes = myNode;
    %populates the nodes
    for i = 1:length(count)
        nodes(i).symbol = i-1;
        nodes(i).frequency = count(i);
    end
    %sorts the nodes
    nodes = myBubbleSort(nodes);
    
%   shifting starts here
    %okay honestly, i assume this will fail if the count was not divisible
    %by 32. 256/32 is 8 blocks but thats assuming all colours existed in
    %the image. idk if that's a safe assumption or not.
    %i think it is safe to assume we have at least 256-32 colours so i'll
    %try to write that now.
    blocksize = 32;
    k = blocksize;
    snodes = myNode;
    blocknum = 1;
    while k <= length(nodes)
        for i = 1+(blocksize*(blocknum-1)):k
            snodes(i-(blocksize*(blocknum-1)), blocknum) = nodes(i);
        end
        k = k+blocksize;
        blocknum = blocknum+1;
    end
    %honestly this part is messy, i added this part to accomodate for the
    %case that not we end up with less than 8 blocks, ie: range of symbol is
    %less than 0 to 255.
    if k < 256
        for i =k:length(nodes);
            snodes(i-(blocksize*(blocknum-1)), blocknum) = nodes(i);
        end
    end
    
    blocknum = blocknum-1;
    k = blocksize;
    tsum = zeros(1,blocknum-1);
    %sums up each block
    for i = 2:blocknum
        for j = 1:k
            tsum(1,i - 1) = tsum(1, i-1)+snodes(j, i).frequency;
        end
    end
    %sums up all blocks:'D
    %i used predefined sum pls dont kill me
    totaltsum = sum(tsum);
    %this became my favourite part, manipulating nodes arrays
    newnodes = myNode;
    %populating the array that contains Ax and the reference block.
    for i = 1:blocksize
        newnodes(i).frequency = nodes(i).frequency;
        newnodes(i).symbol = nodes(i).symbol;
    end
    %keeping track of the reference array, things get messy after
    %recursion and sorting.
    reference = newnodes(1:blocksize);
    newnodes(blocksize+1).frequency = totaltsum;
    %sorting the nodes.
    Ax=newnodes(blocksize+1);
    newnodes = myBubbleSort(newnodes);
    %sadnode feels useless but actually it's a very important node
    %using it to make it feel better!
    %sadnode is honestly love.
    sadnode = myNode;
    sadnode.frequency = 0;
    sadnode.symbol = 257;
    %distributing codes.
    Recurse([newnodes,sadnode]);
    %fixin the, by now, well known bug, assuming you checked this one last.
    newnodes(length(newnodes)).code = newnodes(length(newnodes)).parent.code;
    %granting the codes back to the nodes.
    for i = 1:k
        nodes(i).code = reference(i).code;
    end
    %uhh the same bad assumption..
    %anyway, in short, prefix is the code that Ax got, it repeats equal
    %times to the blocknum-1, so for block 1 it doesnt show but for block 5
    %it shows 4 times, if prefix=='1' then block5.prefix = '1111'
    prefix = Ax.code;
    %fixed the bad assumption
    %prefix = newnodes(1).code (this was the bad assumption, that
    %newnodes(1) will always be Ax)
    %applies the prefix to the codes.
    for i = 1:blocknum-1
        for j = 1:blocksize
            nodes(j+blocksize*i).code = [prefix, reference(j).code];
        end
        %prefix keeps reallocating and i would like to fix that tbh
        prefix = [prefix,char(newnodes(1).code)];
    end
    %writes the dictionary
    WriteDict(nodes,channelnum,'s');
    %writes the binary code file
    disp('pre BinCode printing');
    disp(datestr(now,'HH:MM:SS.FFF'));
    fileID=fopen(['SBinCode',num2str(channelnum),'.txt'],'w');
    nodes=myBubbleSortSymbol(nodes);
    %calculates the number of bits
    A = 0;
    for i = 1:length(nodes);
    A = A + length(nodes(i).code)*nodes(i).frequency;
    end
    
    for i = 1:length(P)
        symbolaya=P(i);
        fprintf(fileID,nodes(symbolaya+1).code);
    end
    
    disp('after BinCode printing');
    disp(datestr(now,'HH:MM:SS.FFF'));
    fclose(fileID);
    %we are doneeee!

end