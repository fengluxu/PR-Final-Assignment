function a = my_rep(m)
imgsize = [20 20];
% Preprocessing for the images (set in square bounding box and resize for same number of pixels)
preproc = im_box([], 0, 1) * im_resize([], imgsize);
a = m * preproc;
a = prdataset(a, getlabels(m));
end
% mapping = a * nlfisherm([]);
% a = a * mapping;