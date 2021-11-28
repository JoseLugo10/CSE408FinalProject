% function to create a vocabulary from multiple text files under folders

function voc = buildVoc(folder)

stopword = {'ourselves', 'hers', 'between', 'yourself', 'but', 'again', 'there', ...
    'about', 'once', 'during', 'out', 'very', 'having', 'with', 'they', 'own', ...
    'an', 'be', 'some', 'for', 'do', 'its', 'yours', 'such', 'into', ...
    'of', 'most', 'itself', 'other', 'off', 'is', 's', 'am', 'or', ...
    'who', 'as', 'from', 'him', 'each', 'the', 'themselves', 'until', ...
    'below', 'are', 'we', 'these', 'your', 'his', 'through', 'don', 'nor', ...
    'me', 'were', 'her', 'more', 'himself', 'this', 'down', 'should', 'our', ...
    'their', 'while', 'above', 'both', 'up', 'to', 'ours', 'had', 'she', 'all', ...
    'no', 'when', 'at', 'any', 'before', 'them', 'same', 'and', 'been', 'have', ...
    'in', 'will', 'on', 'does', 'yourselves', 'then', 'that', 'because', ...
    'what', 'over', 'why', 'so', 'can', 'did', 'not', 'now', 'under', 'he', ...
    'you', 'herself', 'has', 'just', 'where', 'too', 'only', 'myself', ...
    'which', 'those', 'i', 'after', 'few', 'whom', 't', 'being', 'if', ...
    'theirs', 'my', 'against', 'a', 'by', 'doing', 'it', 'how', ...
    'further', 'was', 'here', 'than', ''}; % define English stop words, from NLTK


files = dir(fullfile(folder,'*.txt'));
voc = {};
for file = files'
    [fid, msg] = fopen(fullfile(folder, file.name), 'rt');
    error(msg);
    line = fgets(fid); % Get the first line from
     % the file.
    while line ~= -1
        line = lower(line);
        line = regexprep(line, '[.,''"*!?()&]', '');
        %line = regexprep(line,' 1| 2| 3| 4| 5| 6| 7| 8| 9|','');
        [token, line] = strtok(line);
        while ~strcmp(token,'')
            if ~ismember({token}, stopword)
                voc{end + 1} = token; 
            end
            [token, line] = strtok(line); 
        end
        line = fgets(fid);
    
    end
    fclose(fid);
end

n = 4; % count threshold: limits voc to words with n counts or greater
voc = voc(~cellfun('isempty',voc));
[temp, ~, count] = unique(voc, 'stable');
voc = {};
[count, ~] = groupcounts(count);
for i = 1:length(count)
    if count(i) >= n
        voc(:,end+1) = {temp{i}, count(i)}; % returns voc with word counts
    end
end
