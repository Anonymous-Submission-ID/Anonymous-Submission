function ap_mining_kth(kth_base_path, kth_des_path_ap, kth_des_path_nap)

close all;
r_dirs = dir([kth_base_path '*\']);

% list all sub dirs.
for i = 1 : length(r_dirs)
    if r_dirs(i).isdir && ~isequal(r_dirs(i).name, '.' ) && ~isequal(r_dirs(i).name, '..')
        video_path = [r_dirs(i).folder '\' r_dirs(i).name];
        % for naming the generated imgs
        a = strsplit(video_path, '\');
        kth_des_path_ap = [a{1} '\' a{2} '\' a{3} '\' a{4} '\' a{5} '\' 'processed_major' '\' a{7} '\' a{8} '\'];
        kth_des_path_nap = [a{1} '\' a{2} '\' a{3} '\' a{4} '\' a{5} '\' 'processed_inferior' '\' a{7} '\' a{8} '\'];
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
        samples = cell(length(imgs), 1);
        for i = 1 : length(imgs)
            img_data = imread([video_path '\' imgs(i).name]);
            samples{i} = img_data;
            imshow(img_data)
        end
        
        % separating ap and nap from videos
        Decom_Growth(samples, kth_des_path_ap, kth_des_path_nap, imgs_naming);
    end
end

end

