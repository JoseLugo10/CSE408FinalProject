function feat_vec = createBOW(filepath, voc)

[fid, msg] = fopen(filepath, 'rt');
error(msg);
line = fgets(fid); % Get the first line from the file.
feat_vec = zeros(size(voc)); %Initialize the feature vector'

Bag = [];
while line ~= -1
    line = lower(line);
    line = regexprep(line, '[.,''"*!?()]', '');
    line = regexprep(line,' 1| 2| 3| 4| 5| 6| 7| 8| 9|','');
    [token, remain] = strtok(line);
    while ~strcmp(remain,'')
        Bag{end + 1} = token;
        if (~strcmp(remain, ''))
            [token, remain] = strtok(remain);
        end
    end
    line = fgets(fid);
end

j = 1;
while j < length(voc)+1
    i = 1;
    while i < length(Bag)+1
        if (strcmp(Bag{i},voc{j}))
            feat_vec(j) = feat_vec(j) + 1;
        end
        i = i + 1;
    end
    j = j + 1;
end
fclose(fid);