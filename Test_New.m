a = prnist([0:9],[1:10:500]);
b = prnist([0:9],[900:10:950]);

trn_feature = find_features(a);
tst_feature = find_features(b);
%%
%PCA
pca = trn_feature*pcam([],12);

%%
% Neural Networks
W = bpxnc(trn_feature*pca,30,1000); 
Er_N = tst_feature*pca*W*testc;
disp('Neural Networks_err:');
disp(Er_N);

%%
%loglc
classifier = loglc;
D = [trn_feature]*pca*classifier;
Er_D = tst_feature*pca*D*testc;
disp('loglc_err:');
disp(Er_D);

%%
% combine the classifier
v = [W,D];
Er_v = tst_feature*pca*v*testc;
disp(Er_v);

