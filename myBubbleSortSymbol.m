function A = myBubbleSortSymbol(nodesarr)
%okay give it an array of nodes and it will return the same array but
%sorted descendingly according to the pixel value(symbol) of its nodes
for i=1:length(nodesarr)
   for j=1:length(nodesarr)
       if(nodesarr(i).symbol>nodesarr(j).symbol)
           temp=nodesarr(i);
           nodesarr(i)=nodesarr(j);
           nodesarr(j)=temp;
       end
   end
end
% for i=1:length(nodesarr)-1
%     for j=1:length(nodesarr)-i-1
%         if nodesarr(j+1).frequency>nodesarr(j).frequency
%             swap(nodesarr(j+1),nodesarr(j));
%         end
%     end
% end
A=nodesarr;
end
function swap(node1,node2)
            temp=node1;
            node1=node2;
            node2=temp;
end