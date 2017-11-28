% Main script to cluster the given image

clear all
close all
clc
im = imread('flowers.jpg');
im2 = reshape(im,[size(im,1)*size(im,2) 3]);

% Define cluster number
clusterNo = 8;

% Define maximum number of iterations
maxIter = 500;

% Calculate 
[cmap,V] = KMeansIm(im2, clusterNo, maxIter);
cmap2 = reshape(cmap, [size(im,1) size(im,2)]);
M = V / 255;
clusteredImage = label2rgb(cmap2,M);

% Show the segmented image
figure, imshow(clusteredImage)