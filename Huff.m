function A = Huff(I,channelnum)
disp('begin');
disp(datestr(now,'HH:MM:SS.FFF'));

%linearization(transforming 2d array to 1d)

P=twodto1d(I);
%count frequency of each value(symbol)

count=CountFreq(P);
%a new data type i created (myNode)
nodes = myNode;
%populates the nodes
for i = 1:length(count)
    nodes(i).symbol = i-1;
    nodes(i).frequency = count(i);
end

nodes = myBubbleSort(nodes);

%FOR TESTING PURPOSES ONLY

symbols = [ 2, 6, 1, 4, 3, 5 ];
frequencies = [ 40, 30, 10, 10, 6, 4 ];
nodetest = myNode;

for i =1:length(symbols)
    nodetest(i).symbol=symbols(i);
    nodetest(i).frequency=frequencies(i);
end
%testing purposes ended :D
%sadnode, necessary because of some bug in
%the recursion that I honestly don't have the brain capacity to fix.
sadnode = myNode;
sadnode.frequency = 0;
sadnode.symbol = 256;
Recurse([nodes,sadnode]);
nodes(length(nodes)).code = nodes(length(nodes)).parent.code;
%bug's fixed.
%writes the dictionary.
WriteDict(nodes,channelnum,'h');
%writes the binary code.
fileID=fopen(['HBinCode',num2str(channelnum),'.txt'],'w');

disp('pre BinCode printing');
disp(datestr(now,'HH:MM:SS.FFF'));
disp('hope you are having a nice day :D')

nodes = myBubbleSortSymbol(nodes);
A = 0;
for i = 1:length(nodes);
    A = A + length(nodes(i).code)*nodes(i).frequency;
end
disp('This is the number of bits in the compressed image');
disp(A);
for i = 1:length(P)
    symbolaya=P(i);
    fprintf(fileID,nodes(symbolaya+1).code);
end

fclose(fileID);

disp('after BinCode printing');
disp(datestr(now,'HH:MM:SS.FFF'));
%and we are done!
end
