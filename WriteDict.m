function WriteDict(nodes,channelnum,identifier)
%give it an array of CODED nodes, the number of channel (i use 0 for mono
%channeled images) and an identifier to differentiate between truncated,
%regular and shifted huffman.
%writes the file directly to the current directory.
    dict(1:length(nodes))=myDict;
    for i =1:length(nodes)
        dict(i).code=nodes(i).code;
        dict(i).symbol=nodes(i).symbol;
    end
    if identifier=='h'
        fileid = fopen(['HDict',num2str(channelnum),'.txt'],'w');
    end
    if identifier=='t'
        fileid = fopen(['TDict',num2str(channelnum),'.txt'],'w');
    end
    if identifier=='s'
        fileid = fopen(['SDict',num2str(channelnum),'.txt'],'w');
    end
    for i =1:length(dict)
        fprintf(fileid,char(dict(i).code));
        fprintf(fileid,' : ');
        fprintf(fileid,num2str((dict(i).symbol)));
        fprintf(fileid,char(10));
    end
    fclose(fileid);

end