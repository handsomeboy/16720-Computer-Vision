function [compareX,compareY] = makeTestPattern(patchWidth, nbits)
    k = patchWidth.^2;
    % get test pair compareX is a 256 long vector with elements from 1 to 81
    compareX = randi([1,k],nbits,1);
    compareY = randi([1,k],nbits,1);
     save('testPattern.mat','compareX','compareY');
end
