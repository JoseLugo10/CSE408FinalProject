clear all

posFolder = 'data/leftwing';
negFolder = 'data/rightwing';

leftVoc = buildVoc(posFolder);
rightVoc = buildVoc(negFolder);

[leftVoc, rightVoc] = updateFreq(leftVoc, rightVoc);

leftFiles = dir(fullfile(posFolder,'*.txt'));
rightFiles = dir(fullfile(negFolder,'*.txt'));

% wordsWithStrength is a list of the Sentiment Value of each word

Rtable(:,1) = (rightVoc(1,:).');
Rtable(:,2) = rightVoc(2,:).';

Ltable(:,1) = leftVoc(1,:).';
Ltable(:,2) = leftVoc(2,:).';

wordsWithStrength = [Ltable;Rtable];
wordsWithStrength(:,2) = sortrows(wordsWithStrength(:,2),'descend');

% Debug----------------------------------------
testing = sentiment_Analysis(wordsWithStrength);
% Debug----------------------------------------
