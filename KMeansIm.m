function [cmap,V] = KMeansIm(im, clusterNo, maxIter)
% This function clusters the given image into k clusters.
% Returns the cmap containing the cluster indices of each pixel and
% V matrix containing the k cluster centroid locations.

[pixelNo,~] = size(im);

% Randomly choose k samples as the initial cluster centers
randIndices = randperm(pixelNo,clusterNo);
centers = double(im(randIndices,:));
D = zeros(clusterNo,pixelNo); % Distance matrix
for iter=1:maxIter
    % Partition the pixels of image into the clusters     
    D = pdist2(centers,im);% Calculate eucledian distance
    
    [~,min_indices] = min(D); % Find each pixels' cluster by looking minimum distance values
 
    % Update the cluster centers
    old_centers = centers;
    for j=1:clusterNo
        centers(j,:) = mean(im(min_indices == j,:));
    end
 
    % Check convergence
    if sum(sum(abs(old_centers-centers))) == 0 %< 1e-9
        display(['Centers converged in ' num2str(iter) ' iteration.' ]);
        break;
    end
end

if iter == maxIter
    display(['Centers could not converged in ' num2str(maxIter) ' iteration.' ]);
end

cmap = min_indices';
V = centers;
end