function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, Levels)
    L = size(GaussianPyramid, 3);
    for i = 2:L
        DoGPyramid(:,:,i-1) = GaussianPyramid(:,:,i) - GaussianPyramid(:,:,i-1);
    end
    DoGLevels = Levels(2:end);
end
