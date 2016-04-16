function select_patches()

pos1 = imread('../data/pos1.jpg');
pos1 = rgb2gray(pos1);
pos2 = imread('../data/pos2.jpg');
pos2 = rgb2gray(pos2);
pos3 = imread('../data/pos3.jpg');
pos3 = rgb2gray(pos3);
pos4 = imread('../data/pos4.png');
pos4 = rgb2gray(pos4);
pos5 = imread('../data/pos5.jpg');
pos5 = rgb2gray(pos5);

imshow(pos1)
rec1 = getrect;
rec1 = round(rec1);
temp1 = pos1(rec1(2):rec1(2)+rec1(4),rec1(1):rec1(1)+rec1(3));
template_images_pos{1} = temp1;
imshow(pos2)
rec1 = getrect;
rec1 = round(rec1);
temp1 = pos2(rec1(2):rec1(2)+rec1(4),rec1(1):rec1(1)+rec1(3));
template_images_pos{2} = temp1;
imshow(pos3)
rec1 = getrect;
rec1 = round(rec1);
temp1 = pos3(rec1(2):rec1(2)+rec1(4),rec1(1):rec1(1)+rec1(3));
template_images_pos{3} = temp1;
imshow(pos4)
rec1 = getrect;
rec1 = round(rec1);
temp1 = pos4(rec1(2):rec1(2)+rec1(4),rec1(1):rec1(1)+rec1(3));
template_images_pos{4} = temp1;
imshow(pos5)
rec1 = getrect;
rec1 = round(rec1);
temp1 = pos5(rec1(2):rec1(2)+rec1(4),rec1(1):rec1(1)+rec1(3));
template_images_pos{5} = temp1;

for i = 1:length(template_images_pos)
    sample = template_images_pos{i};
    sample = imresize(sample,[128,128]);
    template_images_pos{i} = sample;
end
save('template_images_pos.mat','template_images_pos')

magic_number = 50;
neg = imread('../data/neg.jpg');
neg = rgb2gray(neg);
[height, width] = size(neg);
maxco = min(height, width) - 128;
index = randperm(maxco, magic_number);
for i = 1:magic_number
    sample = neg(index(i) + (1:128), index(i) + (1:128));
    template_images_neg{i} = sample;
end

neg = imread('../data/test4.jpg');
neg = rgb2gray(neg);
[height, width] = size(neg);
maxco = min(height, width) - 128;
index = randperm(maxco, magic_number);
for i = 1:magic_number
    sample = neg(index(i) + (1:128), index(i) + (1:128));
    template_images_neg{i+magic_number} = sample;
save('template_images_neg.mat','template_images_neg')


end

