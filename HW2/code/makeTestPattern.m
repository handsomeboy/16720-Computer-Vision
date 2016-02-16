function [compareX,compareY] = makeTestPattern(patchWidth, nbits)
    k = patchWidth.^2;
    compareX = randi([1,k],nbits,1);
    compareY = randi([1,k],nbits,1);
%     save('compareX','compareY','testfile.mat');
end
