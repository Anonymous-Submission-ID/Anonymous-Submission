function Decom_Growth(frames, kth_des_path_ap, kth_des_path_nap, imgs_naming)

tic;

%-----------------------------------
%% Parameter initialization
sigma_blur = 5; % for image bluring 
nDims0 = 1; % number of PCA dimensions to use when reconstructing
nDims1 = 3;
plottingActivated = true;
%----------------------------------

%% Preprocess data in a convenient format
disp('Preprocessing data...')

nFrames = length(frames);
[nRows, nCols, nDims] = size(frames{1});
 
nRows2 = nRows; %floor(nRows/2);  % pick a lower scale for faster execution
nCols2 = nCols; %floor(nCols/2);

Data = zeros(nFrames, nRows2*nCols2*nDims);

for i = 1:nFrames
    frames{i} = imresize(ni(frames{i}), [nRows2, nCols2]);    
    frames{i} = ni(frames{i});
    Data(i,:) = frames{i}(:)';
end

%% Principle component decompose 
disp('Running PCA...')

Data = single(Data');
meanData = repmat(mean(Data), nRows2*nCols2*nDims, 1);
Data = Data - meanData;

k = nDims0;
M = Data'*Data;
[v,d] = eig(M);
v = v(:,size(M,1):-1:(size(M,1) - k + 1));
Y = (Data*v(:,1:k))*v(:,1:k)' + meanData;

% % difference k
% k1 = nDims1;
% M = Data'*Data;
% [v,d] = eig(M);
% v1 = v(:,size(M,1):-1:(size(M,1) - k1 + 1));
% Y1 = (Data*v(:,1:k1))*v(:,1:k1)' + meanData;

%% Find the error between original video and reconstruction
disp('Calculating reconstruction error...')

% Save error in im_diff. High pixel values correspond to potential objects of interest 
im_diff = zeros(nFrames, nRows2, nCols2);
frames2 = [];

for i = 1:nFrames
    frames2{i} = reshape(Y(:,i), [nRows2, nCols2, 3]);   % PCA reconstruction
    frames{i} = reshape(frames{i}, [nRows2, nCols2, 3]); % original video 
    
%     % difference k
%     frames1{i} = reshape(Y1(:,i), [nRows2, nCols2, 3]);   % PCA reconstruction 1
    
    aux = frames{i} - frames2{i}; % error map - one for each image channel
    aux = sqrt(sum(aux(:,:,:).^2, 3)); % combine error accross channels
    
    im_diff(i,:,:) = aux;     
    
%     % difference k
%     aux1 = frames{i} - frames1{i}; % error map - one for each image channel
%     aux1 = sqrt(sum(aux1(:,:,:).^2, 3)); % combine error accross channels
%     
%     im_diff1(i,:,:) = aux1;     
end

im_diff = ni(im_diff); % normalize error to be in range [0,1]

% blur error image to make objects more smooth 
aux =  zeros(nRows2, nCols2);
g = fspecial('gaussian', [3*sigma_blur, 3*sigma_blur], sigma_blur);

BW_all  = [];
im_all = [];

G_center =  fspecial('gaussian', [nRows2, nCols2], min(nRows2, nCols2)/3);

% % difference k
% im_diff1 = ni(im_diff1); % normalize error to be in range [0,1]
% 
% % blur error image to make objects more smooth 
% aux1 =  zeros(nRows2, nCols2);
% g1 = fspecial('gaussian', [3*sigma_blur, 3*sigma_blur], sigma_blur);
% 
% BW_all1  = [];
% im_all1 = [];
% 
% G_center1 =  fspecial('gaussian', [nRows2, nCols2], min(nRows2, nCols2)/3);

for i = 1:nFrames

    % filter error map with a Gaussian to get a better shape of the object 
    aux = reshape(im_diff(i,:,:), [nRows2, nCols2]);
    aux = imfilter(aux, g); 
    aux = ni(aux.*G_center);
    
%     % difference k
%     aux1 = reshape(im_diff1(i,:,:), [nRows2, nCols2]);
%     aux1 = imfilter(aux1, g1); 
%     aux1 = ni(aux1.*G_center1);
       
    % save object masks by thresholding the soft segmentation
    BW_all = [BW_all, ni(aux) > 0.5];
    im_all = [im_all, rgb2hsv(frames{i})];
    
%     % difference k
%     BW_all1 = [BW_all1, ni(aux1) > 0.5];
%     im_all1 = [im_all1, rgb2hsv(frames{i})];
    
    
    %seg  = getSeg(ni(aux) > 0.5, rgb2hsv(frames{i}));
    %figure(3), imshow(seg);
    
    if plottingActivated
%         orignal_name = './results/original_%d.jpg'

%         oi = sprintf('results/original_%d.jpg', i);
%         ri = sprintf('results/reconst_%d.jpg', i);
        ei = sprintf('results/error_%d.jpg', i);
%         imwrite(frames{i}, oi);
%         imwrite(frames2{i}, ri);
        
        imshow(ni(aux))
%         imwrite(ni(aux), ei);
        
%         % difference k
%         oi1 = sprintf('results/original_%d.jpg', i);
%         ri1 = sprintf('results/reconst_%d_d.jpg', i);
%         ei1 = sprintf('results/error_%d_d.jpg', i);
%         ri1_d = sprintf('results/reconst_%d_dd.jpg', i);
%         ei1_d = sprintf('results/error_%d_dd.jpg', i);
% %         imwrite(frames{i}, oi);
%         imwrite(frames1{i}, ri1);
%         imwrite(ni(aux1), ei1);
%         imwrite(frames2{i}-frames1{i}, ri1_d);
%         imwrite(ni(aux1)-ni(aux), ei1_d);
% %         hold on;
        
%         [m, ind] = max(aux(:));
%         [y,x] = ind2sub([nRows2, nCols2], ind);
%         rectangle('Position', [x-16, y-16, 33, 33], 'EdgeColor', [1 0 0]); 
%         pause(0.01)
    end
    
end

t0 = toc;
fprintf('Number of processed frames: %d \n', nFrames)
fprintf('Time elapsed: %f \n', t0)
fprintf('Time per frame: %f \n', t0/nFrames)


%% Growth transformation on reconstructions
disp('Creating image segmentation ...')

seg_all = getSeg(BW_all, im_all);

video_seg = [];
video_seg1 = [];

for i = 1:nFrames
     
    seg = seg_all(:,(i-1)*nCols2+1:i*nCols2); 
    %seg(seg < 0.5) = 0; % uncomment for binary segmentation
 
    aux = hysthresh(ni(seg.*G_center), 0.8, 0.5);  
    video_seg{i} = ni(seg.*aux);
    video_seg1{i} = ni(seg.*G_center);

    if plottingActivated
        si = sprintf('results/seg_%d.jpg', i);
        ap_path = [kth_des_path_ap imgs_naming(i).name];
        nap_path = [kth_des_path_nap imgs_naming(i).name];
        
        imwrite(ni(seg.*G_center), ap_path);
        imshow(ni(seg.*G_center))
        
        temp_in = ni(seg.*G_center);
        if length(size(temp_in)) < 3
            temp_in(:,:,1)=1-temp_in(:,:,1);
        else
            temp_in(:,:,1)=1-temp_in(:,:,1);
            temp_in(:,:,2)=1-temp_in(:,:,2);
            temp_in(:,:,3)=1-temp_in(:,:,3);
        end
        imwrite(temp_in, nap_path);
        imshow(temp_in)
        
    end    
end

% % difference k
% %% Create image segmentation from reconstruction
% disp('Creating image segmentation ...')
% 
% seg_all1 = getSeg(BW_all1, im_all1);
% 
% video_seg = [];
% video_seg1 = [];
% 
% for i = 1:nFrames
%      
%     seg1 = seg_all1(:,(i-1)*nCols2+1:i*nCols2); 
%     %seg(seg < 0.5) = 0; % uncomment for binary segmentation
%  
%     aux1 = hysthresh(ni(seg1.*G_center1), 0.8, 0.5);  
%     video_seg{i} = ni(seg1.*aux1);
%     video_seg1{i} = ni(seg1.*G_center1);
%     
%     si1 = sprintf('results/seg_%d_d.jpg', i);
%     imwrite(ni(seg1.*G_center1), si1);
%     si1_d = sprintf('results/seg_%d_dd.jpg', i);
%     imwrite(ni(seg1.*G_center1)-ni(seg.*G_center), si1_d); 
% end


end
