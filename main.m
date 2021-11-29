clear all

posFolder = 'data/leftwing';
negFolder = 'data/rightwing';

leftVoc = buildVoc(posFolder);
rightVoc = buildVoc(negFolder);

[leftVoc, rightVoc] = updateFreq(leftVoc, rightVoc);

leftFiles = dir(fullfile(posFolder,'*.txt'));
rightFiles = dir(fullfile(negFolder,'*.txt'));

%leftLabelSet = [];
leftFeatSet = [];
for file = leftFiles'
    %leftLabelSet =  %TODO
    featVec = createBOW(fullfile(file.folder,file.name), leftVoc(1,:));
    leftFeatSet = [leftFeatSet,featVec'];
end

%rightLabelSet = [];
rightFeatSet = [];
for file = leftFiles'
    %rightLabelSet =  %TODO
    featVec = createBOW(fullfile(file.folder,file.name), rightVoc(1,:));
    rightFeatSet = [rightFeatSet,featVec'];
end

% wordsWithStrength is a list of the Sentiment Value of each word
temp = cell2mat(rightVoc(2,:).');
temp(:,1) = temp(:,1)*-1;

Rtable = table;
Ltable = table;
Rtable.words = rightVoc(1,:).';
Rtable.strength = temp;

temp = cell2mat(leftVoc(2,:).');
temp(:,1) = temp(:,1)*1;

Ltable.words = leftVoc(1,:).';
Ltable.strength = temp;

wordsWithStrength = [Ltable;Rtable];
wordsWithStrength = sortrows(wordsWithStrength,'strength','descend');
