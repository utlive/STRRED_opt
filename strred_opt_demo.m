% Copyright (c) 2017 The University of Texas at Austin
% All rights reserved.
%
% Permission to use, copy, or modify this software and its documentation for
% educational and research purposes only and without fee is hereby granted,
% provided that this copyright notice and the original authors' names appear on
% all copies and supporting documentation. This program shall not be used, rewritten,
% or adapted as the basis of a commercial software or hardware product without first
% obtaining permission of the authors. The authors make no representations about the
% suitability of this software for any purpose. It is provided "as is" without express
% or implied warranty.

% The following papers are to be cited in the bibliography whenever the software is used
% as:
% C. G. Bampis, P. Gupta, R. Soundararajan and A. C. Bovik, "SpEED-QA: Spatial Efficient 
% Entropic Differencing for Image and Video Quality", Signal Processing
% Letters, under review
% R. Soundararajan and A. C. Bovik, "RRED indices: Reduced reference entropic
% differences for image quality assessment", IEEE Transactions on Image
% Processing, vol. 21, no. 2, pp. 517-526, Feb. 2012

clear
close all
clc

addpath(genpath('matlabPyrTools'))
addpath(genpath('functions'))

band = 4;
Nscales = 5;
Nor = 6;
blk = 3;
sigma_nsq = 0.1;
frame_width = 176;
frame_height = 144;
Nframes = 10;

ref_video = [pwd '/foreman_org_qcif.yuv'];
dis_video = [pwd '/foreman_dst_qcif.yuv'];

srred = zeros(1, Nframes);
trred = zeros(1, Nframes);
srred_opt = zeros(1, Nframes);
trred_opt = zeros(1, Nframes);
time_strred = zeros(1, Nframes);
time_strred_opt = zeros(1, Nframes);

for frame_ind = 1 : Nframes
    
    if frame_ind < Nframes
        
        ref_frame = read_single_frame(ref_video, frame_ind, ...
            frame_height, frame_width);
        ref_frame_next = read_single_frame(ref_video, frame_ind + 1, ...
            frame_height, frame_width);
        
        dis_frame = read_single_frame(dis_video, frame_ind, ...
            frame_height, frame_width);
        dis_frame_next = read_single_frame(dis_video, frame_ind + 1, ...
            frame_height, frame_width);
        
        tic
        
        [srred_opt(frame_ind), ~, trred_opt(frame_ind), ~] = STRRED_optim(ref_frame_next, ref_frame, ...
            dis_frame_next, dis_frame, band, Nscales, Nor, ...
            blk, sigma_nsq);
        
        time_strred_opt(frame_ind) = toc;
        
        tic
        
        [spatial_ref, temporal_ref] = extract_info(ref_frame_next, ref_frame);
        [spatial_dis, temporal_dis] = extract_info(dis_frame_next, dis_frame);
        
        srred(frame_ind) = mean2(abs(spatial_ref-spatial_dis));
        trred(frame_ind) = mean2(abs(temporal_ref-temporal_dis));
        
        time_strred(frame_ind) = toc;
        
    else
        
        srred(frame_ind) = srred(frame_ind-1);
        trred(frame_ind) = trred(frame_ind-1);
        
        srred_opt(frame_ind) = srred_opt(frame_ind-1);
        trred_opt(frame_ind) = trred_opt(frame_ind-1);
        
    end;
    
end;

disp(['ST-RRED needs: ' num2str(mean(time_strred)) ', for ' num2str(Nframes) ' frames of size ' num2str(frame_width) 'x' num2str(frame_height)])
disp(['ST-RREDopt needs: ' num2str(mean(time_strred_opt)) ', for ' num2str(Nframes) ' frames of size ' num2str(frame_width) 'x' num2str(frame_height)])
disp('larger gains can be achieved for larger video files')




















