function scorelist = sentiment_Analysis(lexicon, folder)

scorelist = {};
sentimentScore = 0;

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

%Find Lefts training files 
files = dir(fullfile(folder,'*.txt'));
for file = files'
%sentimentScore = 0;
fileVoc = {};

%extract contents of the file
    [fid, msg] = fopen(fullfile(folder, file.name), 'rt');
    error(msg);
    line = fgets(fid); % Get the first line from
     % the file.
    while line ~= -1
        line = lower(line);
        line = regexprep(line, '[.,''"*!?()&]', '');
        [token, line] = strtok(line);
        while ~strcmp(token,'')
            if ~ismember({token}, stopword)
                fileVoc{end + 1} = token; 
            end
            [token, line] = strtok(line); 
        end
        line = fgets(fid);
    
    end
    fclose(fid);
    % Search the fileVoc for any wordsWithStrength and add the values for
    % the words.
    for k=1 : numel(fileVoc)
        Index = find(strcmp((fileVoc(k)), lexicon(:,1)));
            if Index > 0
            sentimentScore = sentimentScore + lexicon{Index,2};
            end
    end
scorelist{end + 1} = sentimentScore;
sentimentScore = 0;
end

