function  Recurse(nodes)
    %Okay wa7da wa7da m3aya
    %Recurse uses recursion, give it an array of nodes and it will return
    %to you the same array of nodes except, they will have huffman codes now!
    newN=nodes;
    %honestly after reading this thoroughly to comment, i now understand
    %why we had the bug that required using sadnode.
    %I would love to propose a fix but this would mean changing everything
    %else so no thank you.
    temp=myNode;
    temp.frequency=newN(length(newN)-1).frequency+newN(length(newN)).frequency;
    %merging the smallest 2 nodes
    newN(end)=[];
    newN(end)=[];
    newN(length(newN)+1)=temp;
    %merge complete.
    
    nodes(length(nodes)).parent=newN(length(newN));
    nodes(length(nodes)-1).parent=newN(length(newN));
    %assigning parents!
    %sorting nodes
    newN=myBubbleSort(newN);
    %basically, while length(newN)>2 keep recursing.
    if length(newN)>2
        Recurse(newN);
    end
    %assigning codes!
    smallest=length(newN);
    if ~isempty(newN(smallest).parent)
        newN(smallest).code = [newN(smallest).parent.code, '0'];
    else
        newN(smallest).code='0';
    end
    if ~isempty(newN(smallest-1).parent)
        newN(smallest-1).code = [newN(smallest-1).parent.code, '1'];
    else
        newN(smallest-1).code='1';
    end
    %done, its simple.
end