clear all

posFolder = 'data/rightwing';
negFolder = 'data/leftwing';

leftVoc = buildVoc(posFolder);
rightVoc = buildVoc(negFolder);

[leftVoc, rightVoc] = updateFreq(leftVoc, rightVoc);

leftFiles = dir(fullfile(posFolder,'*.txt'));
rightFiles = dir(fullfile(negFolder,'*.txt'));

% wordsWithStrength is a list of the politically Sentiment Value of each word

Rtable(:,1) = (rightVoc(1,:).');
Rtable(:,2) = rightVoc(2,:).';

Ltable(:,1) = leftVoc(1,:).';
Ltable(:,2) = leftVoc(2,:).';

wordsWithStrength = [Ltable;Rtable];
wordsWithStrength = sortrows(wordsWithStrength,2,'descend');

% perform Sentiment Analysis for 10 positive files and 10 negative files
posTestingFolder = 'data/testing/rightwing';
negTestingFolder = 'data/testing/leftwing';

testingList(1,:) = sentiment_Analysis(wordsWithStrength,posTestingFolder);
testingList(2,:) = sentiment_Analysis(wordsWithStrength,negTestingFolder);

% count correct and incorrect for accuacy 
total = numel(testingList);
correct = 0;
%check number of correct on both sides, zeros count as incorrect
for j = 1 : numel(testingList(1,:))
    if(testingList{1,j} > 0)
    correct = correct + 1;
    end
end
for j = 1 : numel(testingList(2,:))
    if(testingList{2,j} < 0)
    correct = correct + 1;
    end
end
fprintf('Num Correct = %i/%i\n',correct,total);
