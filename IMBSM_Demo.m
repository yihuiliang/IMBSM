delete(gcp('nocreate'));
parpool('local');
max_fitness_evaluation_per_unknow_pixel = 50;
img = imread('GT20.png');
trimap = imread('trimap.png');
tic;
alpha = IMBSM_matting(img,trimap,max_fitness_evaluation_per_unknow_pixel);
toc
figure,imshow(img);
figure,imshow(alpha);
