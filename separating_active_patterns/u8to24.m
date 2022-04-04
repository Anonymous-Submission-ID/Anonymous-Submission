function u8to24(kth_base_path, kth_des_path_ap, kth_des_path_nap)

close all;

% 1: replace here with kth_des_path_ap, 2: then kth_des_path_nap
fprintf('convertting ap.')

r_dirs = dir([kth_des_path_ap '*\']);

% list all sub dirs.
for i = 1 : length(r_dirs)
    if r_dirs(i).isdir && ~isequal(r_dirs(i).name, '.' ) && ~isequal(r_dirs(i).name, '..')
        video_path = [r_dirs(i).folder '\' r_dirs(i).name];
        % for naming the generated imgs
        a = strsplit(video_path, '\');
        kth_des_path_ap = [a{1} '\' a{2} '\' a{3} '\' a{4} '\' a{5} '\' 'processed_major24' '\' a{7} '\' a{8} '\'];
        kth_des_path_nap = [a{1} '\' a{2} '\' a{3} '\' a{4} '\' a{5} '\' 'processed_inferior24' '\' a{7} '\' a{8} '\'];
        % create dirs
        if ~exist(kth_des_path_ap,'dir')
            mkdir(kth_des_path_ap)
        end
        if ~exist(kth_des_path_nap,'dir')
            mkdir(kth_des_path_nap)
        end
        
        fprintf('%s is under processing, procedure: %d in %d\n', video_path, i, length(r_dirs))
        imgs = dir([video_path '\*.png']);
        % for naming the generated imgs
        imgs_naming = imgs;
        
        imgs = imgs(1:length(imgs), :);

        for i = 1 : length(imgs)
            img_data = imread([video_path '\' imgs(i).name]);
%             samples{i} = img_data;
%             imshow(img_data)
            img_data24(:, :, 1) = img_data;
            img_data24(:, :, 2) = img_data;
            img_data24(:, :, 3) = img_data;
%             imwrite(img_data24, [video_path '\' imgs(i).name]);
            % 1: replace it by kth_des_path_ap
            imwrite(img_data24, [kth_des_path_ap imgs(i).name]);
        end
    end
end

% 2. 
fprintf('convertting nap.')
r_dirs = dir([kth_des_path_nap '*\']);

for i = 1 : length(r_dirs)
    if r_dirs(i).isdir && ~isequal(r_dirs(i).name, '.' ) && ~isequal(r_dirs(i).name, '..')
        video_path = [r_dirs(i).folder '\' r_dirs(i).name];
        % for naming the generated imgs
        a = strsplit(video_path, '\');
        kth_des_path_ap = [a{1} '\' a{2} '\' a{3} '\' a{4} '\' a{5} '\' 'processed_major24' '\' a{7} '\' a{8} '\'];
        kth_des_path_nap = [a{1} '\' a{2} '\' a{3} '\' a{4} '\' a{5} '\' 'processed_inferior24' '\' a{7} '\' a{8} '\'];
        % create dirs
        if ~exist(kth_des_path_ap,'dir')
            mkdir(kth_des_path_ap)
        end
        if ~exist(kth_des_path_nap,'dir')
            mkdir(kth_des_path_nap)
        end
        
        fprintf('%s is under processing, procedure: %d in %d\n', video_path, i, length(r_dirs))
        imgs = dir([video_path '\*.png']);
        % for naming the generated imgs
        imgs_naming = imgs;
        
        imgs = imgs(1:length(imgs), :);
%         imgs = imgs(1:10, :);
%         samples = cell(length(imgs), 1);
        for i = 1 : length(imgs)
            img_data = imread([video_path '\' imgs(i).name]);
%             samples{i} = img_data;
%             imshow(img_data)
            img_data24(:, :, 1) = img_data;
            img_data24(:, :, 2) = img_data;
            img_data24(:, :, 3) = img_data;
%             imwrite(img_data24, [video_path '\' imgs(i).name]);
            % 2: kth_des_path_nap
            imwrite(img_data24, [kth_des_path_nap imgs(i).name]);

%             imshow(img_data24);
        end
    end
end