% This script file is an example of the usage 

N=128;   % points per row / column

% Construct the raw data of the phantom
% and write it to input_f.dat
% To use another example than the phantom
% just put the reshape of your example into input_data_f.dat
output = reshape(phantom(N),1,N*N);
save input_f.dat -ascii output

% Construct the knots in k-space and write them to knots.dat
% Different knots like spiral,rose,radial or linogram can be chosen
% M is the number of knots
M = construct_knots_spiral(N,1);

% Make a 2d-NFFT on the constructed knots
% and write the output to output_data_phantom_nfft.dat
system(['./construct_data_2d ' 'output_phantom_nfft.dat ' ...
         int2str(N) ' ' int2str(M)]);

% Precompute the weights using voronoi cells
% and write them to weights.dat
precompute_weights('output_phantom_nfft.dat',M);

% Make an inverse 2d-NFFT
% and write the output to output_real.dat and output_imag.dat
% The usage is "./reconstruct_data_2 filename N M ITER WEIGHTS"
% where ITER is the number of iteration and WEIGHTS is 1
% if the weights are used 0 else
system(['./reconstruct_data_2d ' 'output_phantom_nfft.dat ' ...
         int2str(N) ' ' int2str(M)  ' 3 1']);

% Visualize the two dimensional phantom. Make a pic
% and one plot of the N/2 row
visualize_data('pics/pic_2d', N, 1, 'Inverse 2d-NFFT - 3. iteration');

% Compute the signal to noise ratio 
snr('pics/snr_2d.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The same as above but reconstructed with gridding
% That means an adjoint 2d-NFFT
% The ITER parameter is unused and just for compatibility
system(['./reconstruct_data_gridding ' 'output_phantom_nfft.dat ' ...
         int2str(N) ' ' int2str(M)  ' 5 1']);
visualize_data('pics/pic_gridding', N, 2, '2d-NFFT (Gridding)');
snr('pics/snr_gridding.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%!rm knots.dat
%!rm weights.dat
%!rm input_f.dat
%!rm output_phantom_nfft.dat
%!rm output_imag.dat
%!rm output_real.dat
