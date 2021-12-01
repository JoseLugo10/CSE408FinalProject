clear all

posFolder = 'data/leftwing';
negFolder = 'data/rightwing';

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
posTestingFolder = 'data/testing/leftwing';
negTestingFolder = 'data/testing/rightwing';

testingList(2,:) = sentiment_Analysis(wordsWithStrength,negTestingFolder);
testingList(1,:) = sentiment_Analysis(wordsWithStrength,posTestingFolder);
% Debug----------------------------------------
