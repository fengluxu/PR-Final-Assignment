a = prnist([0:9],[1:5:1000]);
tst = prnist([0:9],[500:5:510]);
show(a);

imgsize = [20 20];
preproc = im_box([], 0, 1) * im_resize([], imgsize);
a = a * preproc;
tst = tst * preproc;

n = 15;

%Classifier
classifier = nmc;
A = a*datasetm*(pcam([],n)*classifier);
Er_A = tst*A*testc;
disp('nmc_err:');
disp(Er_A);

classifier = ldc;
B = a*datasetm*(pcam([],n)*classifier);
Er_B = tst*B*testc;
disp('ldc_err:');
disp(Er_B);

classifier = fisherc;
C = a*datasetm*(pcam([],n)*classifier);
Er_C = tst*C*testc;
disp('fisherc_err:');
disp(Er_C);

classifier = loglc;
D = a*datasetm*(pcam([],n)*classifier);
Er_D = tst*D*testc;
disp('loglc_err:');
disp(Er_D);
%E = cleval(tst,D);

classifier = knnc;
W = a*datasetm*(pcam([],n)*classifier);
Er_K = tst*W*testc;
disp('knnc_err:');
disp(Er_K);

classifier = parzenc;
P = a*datasetm*(pcam([],n)*classifier);
Er_P = tst*P*testc;
disp('parzenc_err:');
disp(Er_P);



[W J] = svc(a,proxm('p',3));
Er_W = tst*W*testc;
disp('svc_err:');
disp(Er_W);

% Neural Networks
N = bpxnc(a,2,1000); 
Er_N = tst*N*testc;
disp('Neural Networks_err:');
disp(Er_N);

%The Nonlinear Support Vector Machine
[W J] = svc(a,proxm('p',3));
Er_W = tst*W*testc;
disp('svc_err:');
disp(Er_W);

%Cluster
[P,lab,WS] = kmclust(a,1,false,false);

%Decision Tree
W = treec(A,CRIT,PRUNE,T);

%Is Classifier Combination Needed(???)

%FEATURE SELECTION
Test = Feature*pcam([],15);
[W,R] = featselo(Feature,'maha-s',15);
 
%Cross Validation
M = 1;

[ERR1,CERR,NLAB_OUT] = prcrossval(Feature*Test,nmc,10,M);

[ERR2,CERR,NLAB_OUT] = prcrossval(Feature*Test,ldc,10,M);

[ERR3,CERR,NLAB_OUT] = prcrossval(Feature*Test,fisherc,10,M);

[ERR4,CERR,NLAB_OUT] = prcrossval(Feature*Test,loglc,10,M);

[ERR5,CERR,NLAB_OUT] = prcrossval(Feature*Test,knnc,10,M);

[ERR6,CERR,NLAB_OUT] = prcrossval(Feature*Test,parzenc,10,M);