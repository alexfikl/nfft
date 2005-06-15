% This script file is an example of the usage 

N=128;   % points per row / column
Z=36;    % number of slices 

% Construct the raw data of the phantom
% and write it to input_f.dat
% To use another example than the phantom
% just put the reshape of your example into input_f.dat
construct_phantom(N,Z);

% Construct the nodes in k-space and write them to nodes.dat
% Different nodes like spiral,rose,radial or linogram can be chosen
% M is the number of nodes
M = construct_nodes_spiral(N);

% First make N^2 1d-FFT, then Z 2d-NFFT on the constructed nodes
% and write the output to output_phantom_nfft.dat
system(['./construct_data ' 'output_phantom_nfft.dat '...
         int2str(N) ' ' int2str(M) ' ' int2str(Z)]);

% Precompute the weights using voronoi cells
% and write them to weights.dat
precompute_weights('output_phantom_nfft.dat',M);

% First make Z inverse 2d-NFFT, then N^2 inverse 1d-FFT
% and write the output to output_real.dat and output_imag.dat
% The usage is "./reconstruct_data_2+1d filename N M Z ITER WEIGHTS"
% where ITER is the number of iteration and WEIGHTS is 1
% if the weights are used 0 else
%system(['./reconstruct_data_2+1d ' 'output_phantom_nfft.dat ' ...
%         int2str(N) ' ' int2str(M) ' ' int2str(Z)  ' 1 1']);

% Visualize the three dimensional phantom. Makes a pic of
% every slice and one plot of the N/2 row of the 10th plane.
%visualize_data('pics_2+1d/pic', N,Z);

% Compute the signal to noise ratio 
%snr('pics_2+1d/snr.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The same as above but reconstructed with gridding. 
% That means first an adjoint 2d NFFT, then a 1d FFT. 
% The ITER parameter is obsolent and just for compatibility
system(['./reconstruct_data_gridding ' 'output_phantom_nfft.dat ' ...
         int2str(N) ' ' int2str(M) ' ' int2str(Z)  ' 5 1']);
visualize_data('pics_gridding/pic', N,Z);
snr('pics_gridding/snr.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The same as above but reconstructed with a 3d nfft
%system(['./reconstruct_data_3d ' 'output_phantom_nfft.dat ' ...
%         int2str(N) ' ' int2str(M) ' ' int2str(Z)  ' 5 1']);
%visualize_data('pics_3d/pic', N,Z);
%snr('pics_3d/snr.txt');

!rm nodes.dat
!rm weights.dat
!rm input_f.dat
!rm output_phantom_nfft.dat
!rm output_imag.dat
!rm output_real.dat