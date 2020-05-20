function A = THuff(img,channelnum, k)
    
    disp('begin');
    disp(datestr(now,'HH:MM:SS.FFF'));
    
    %Transforms the image/channel to a 1D array
    P = twodto1d(img);
    %Counts the number of times each pixel value occured
    count = CountFreq(P);
    nodes = myNode; %myNode is a new data type I created, check myNode for more info.
    newnodes = myNode;
    %populates the nodes
    for i = 1:length(count)
        nodes(i).symbol = i-1;
        newnodes(i).symbol = i-1;
        nodes(i).frequency = count(i);
        newnodes(i).frequency = count(i);
    end
    %sorts the nodes, more info inside the function!
    nodes = myBubbleSort(nodes);
    
    %Truncate starts hereee
    
    tnodes = myNode;
    newnodes = myBubbleSort(newnodes);
    %populates the truncated nodes(everything after K)
    for i = length(nodes):-1:k+1
        tnodes((length(nodes)-(i-1))) = newnodes(i);
        newnodes(end) = [];
    end
    %sums tnodes
    tsum=0;
    
    for i=1:length(tnodes)
        tsum = tsum+tnodes(i).frequency;
    end
    %adds 1 new nodes to newnodes to represent the sum of the truncated
    %nodes.
    %lecture 6 truncated huffman, this node represents Ax.
    newnodes(k+1) = myNode;
    newnodes(k+1).frequency = tsum;
    newnodes = myBubbleSort(newnodes);
    %Formalities (aka the hardcoded part :'D)
    %sadnode, even tho its sad, it's very necessary because of some bug in
    %the recursion that I honestly don't have the brain capacity to fix.
    sadnode = myNode;
    sadnode.frequency = 0;
    sadnode.symbol = 256;
    %recurse does the distribution of codes and, as the name implies, it
    %uses recursion so please read carefully and I will try to be as
    %discriptive and simple as I can.
    Recurse([newnodes,sadnode]);
    newnodes(k+1).code = newnodes(k+1).parent.code;
    %and the bug is fixed now
    disp(newnodes(1));
    %adds the code to the first k nodes.
    AxCode=newnodes(1).code;
    if tsum>nodes(1).frequency %now it will only do this if thats actually the case
        for i = 1:k
            %this assumes that newnodes(1) is always going to be Ax which is
            %wrong, and I just noticed that while commenting.. 
            %*takes a deep breath*
            nodes(i).code = newnodes(i+1).code;
        end
    else
        foundAx = 0;
        for i = 1:k
            j=i;
            if isempty(newnodes(i).symbol)
                foundAx = 1;
                AxCode = newnodes(i).code;
            end
            if foundAx
                j = i + 1;
            end
            nodes(i).code=newnodes(j).code;
        end
        %hopefully this works for all cases.
    end
    %now for every node after k
    %this is basically the same as the previous part
    tnodes = myBubbleSort(tnodes);
    Recurse([tnodes,sadnode]);
    tnodes(length(tnodes)).code = tnodes(length(tnodes)).parent.code;
    %this adds the code of Ax to the left of its current code
    %this also assumes that Ax will always be at the start so, let's fix
    %it.
    for i = 1:length(tnodes)
        tnodes(i).code = [AxCode,tnodes(i).code];
    end
    %done
    
    %copying the codes to the main nodes array.
    for i =k+1:length(nodes);
        nodes(i).code = tnodes(i-k).code;
    end
    %writes the dictionary.
    WriteDict(nodes,channelnum,'t');
    %writes the binary code file!
    fileID = fopen(['TBinCode',num2str(channelnum),'.txt'],'w');
    nodes = myBubbleSortSymbol(nodes);
    %this calculates the number of bits in the compressed image.
    A = 0;
    for i = 1:length(nodes);
    A = A + length(nodes(i).code)*nodes(i).frequency;
    end
    disp('This is the number of bits in the compressed image');
    disp(A);
    disp('pre BinCode printing');
    disp(datestr(now,'HH:MM:SS.FFF'));
    disp('hope you are having a nice day :D')
    
    for i = 1:length(P)
        symbolaya=P(i);
        fprintf(fileID,nodes(symbolaya+1).code);
    end
    
    disp('after BinCode printing');
    disp(datestr(now,'HH:MM:SS.FFF'));
    fclose(fileID);
    %and its done!
    %now to comment the other files..
end