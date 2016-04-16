function tl_detect_script

load('template_images_pos.mat');
load('template_images_neg.mat');
Itest = imread('../data/test_3.jpg');
Itest = imresize(Itest, 2);
ndet = 4;

template1 = template_images_pos{1};
template = hog(template1);
[x,y,score] = detect(Itest,template,ndet);
draw_detection(Itest,ndet,x,y,1);


template = tl_pos(template_images_pos);
[x,y,score] = detect(Itest,template,ndet);
draw_detection(Itest,ndet,x,y,1);


template = tl_pos_neg(template_images_pos, template_images_neg);
[x,y,score] = detect(Itest,template,ndet);
draw_detection(Itest,ndet,x,y,1);

lambda = 1;
template = tl_lda(template_images_pos, template_images_neg, lambda);
[x,y,score] = detect(Itest,template,ndet);
draw_detection(Itest,ndet,x,y,1);

detres = multiscale_detect(Itest, template, ndet);
draw_detection(Itest, ndet, detres(:,1), detres(:,2), 1);

end

function draw_detection(Itest,ndet,x,y, scale) 
% please complete this function to show the detection results
% Itest: Test image
% ndet: number of detections
% x : x-ccordinate of all detections. Dimensions: ndet×1
% y : y-ccordinate of all detections. Dimensions: ndet×1
% scale: scale corresponding to the detection
figure; clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)-64 y(i)-64 128 128],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end
end
