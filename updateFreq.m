function [left, right] = updateFreq(left, right)

% Build new lists using old ones.
tempLeft = left;
left = {};
tempRight = right;
right = {};

% Add values unique to tempLeft to left
for i = 1:numel(tempLeft(1,:))
    if ~any(strcmp(tempRight(1,:),tempLeft(1,i)))
        left(:,end+1) = {tempLeft{1,i}, 1};
    end
end

% Add values unique to tempRight to right
for i = 1:numel(tempRight(1,:))
    if ~any(strcmp(tempLeft(1,:),tempRight(1,i)))
        right(:,end+1) = {tempRight{1,i}, 1};
    end
end

% Look at shared values for both and add based on frequency
for i = 1:numel(tempLeft(1,:))
    if any(strcmp(tempRight(1,:),tempLeft(1,i)))
        rightValue = tempRight{2, find(strcmp({tempRight{1,:}}, tempLeft{1,i}))};
        freq = (tempLeft{2,i} - rightValue)/(tempLeft{2,i}+rightValue);
        if freq > 0
            left(:,end+1) = {tempLeft{1,i}, freq};
        elseif freq < 0
            right(:,end+1) = {tempLeft{1,i}, freq*-1};
        else %TODO decide what to do on ties
            left(:,end+1) = {tempLeft{1,i}, 0};
            right(:,end+1) = {tempLeft{1,i}, 0};
        end
    end
end