function [] = visualize_data ( file, N, num_fig, caption )

load output_real.dat
load output_imag.dat

A=reshape(abs(output_real+i*output_imag),N,N);

for k=1:N,
  for l=1:N,
    if sqrt((l-N/2)^2+(k-N/2)^2)>N/2,
      A(k,l)=0;
    end
  end
end

% plot the two dimensional phantom
figure(2*num_fig-1)
imagesc(A, [0 1.2]);
colormap(gray(256));
colorbar;
title(caption);
file_out =[file '.jpg'];
print('-djpeg',file_out);

% plot the N/2 row
figure(2*num_fig)
file_out = [file 'row' '.png'];
plot(1:N,A(N/2,:));
axis([1 N 0 1.2]);
title([caption ' - The 64th row']);
print('-djpeg',file_out);

