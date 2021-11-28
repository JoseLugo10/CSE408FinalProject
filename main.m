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