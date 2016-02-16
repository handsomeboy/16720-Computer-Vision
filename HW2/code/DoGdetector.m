function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r)
    GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
    [DoGPyramid, DoGlevels] = createDoGPyramid(GaussianPyramid, levels);
    PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
    locsDoG = getLocalExtrema(DoGPyramid, DoGlevels, PrincipalCurvature, th_contrast, th_r);
end

