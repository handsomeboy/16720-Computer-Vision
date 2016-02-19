function [locsDoG] = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)
    locsDoG = [];
    [r,c,l] = size(DoGPyramid);
    DoGPyramid = [DoGPyramid(1,:,:); DoGPyramid; DoGPyramid(r,:,:)];
    DoGPyramid = [DoGPyramid(:,1,:) DoGPyramid DoGPyramid(:,c,:)];
    DoGPyramid = cat(3,DoGPyramid(:,:,1), DoGPyramid, DoGPyramid(:,:,l));
    for k = 2:l+1
        for y = 2:r+1
            for x = 2:c+1
                max_space = DoGPyramid(y-1:y+1,x-1:x+1,k-1:k+1);
                % maybe minimum value also works
                if(DoGPyramid(y,x,k) == max(max_space(:)) || DoGPyramid(y,x,k) == min(max_space(:)))
                    if(abs(DoGPyramid(y,x,k)) > th_contrast && PrincipalCurvature(y-1,x-1,k-1) <= th_r)
                        locsDoG = [locsDoG; x y DoGLevels(k-1)];
                    end
                end
            end
        end
    end
end

