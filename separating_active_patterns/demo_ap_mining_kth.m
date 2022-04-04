function ap_mining_kth
% provide dirs of processed images
kth_base_path = '.\data\kth\processed\';
kth_des_path_ap = '.\data\kth\processed_ap\';
kth_des_path_nap = '.\data\kth\processed_nap\';

% sparating active patterns along with non-active patterns from kth videos
ap_mining_kth(kth_base_path, kth_des_path_ap, kth_des_path_nap)

% convert 1-channel patterns into 3-channel patterns
u8to24(kth_base_path, kth_des_path_ap, kth_des_path_nap)

end