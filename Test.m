a = prnist([0:9],[1:10:50]);
show(a);

%Pixel representation


%PCA
[W,FRAC] = pcam(a,10);
b = gendat(a,50);
w = proxm(b); % define an Euclidean distance mapping to the objects in b
c = a*w; % construct a dissimilarity representation for a
scatterd(c*pcam(c,2)); % compute and plot a PCA

show(selclass(a,[1:10]),10)
   % compute a PCA, convert to dataset first
   % (this is easy here as all images have the same size)
w = a*datasetm*pcam([],2);
   % show the first two eigenfaces
figure; show(w);
   % project all images on the eigenfaces and show the scatter
figure; scatterd(a*w); axis equal


%Classifier
A = nmc(trn);
Er_A = tst*A*testc;
disp('nmc_err:');
disp(Er_A);

B = ldc(trn);
Er_B = tst*B*testc;
disp('ldc_err:');
disp(Er_B);

C = fisherc(trn);
Er_C = tst*C*testc;
disp('fisherc_err:');
disp(Er_C);

D = loglc(trn);
Er_D = tst*D*testc;
disp('loglc_err:');
disp(Er_D);

[W J] = svc(trn);
Er_W = tst*W*testc;
disp('svc_err:');
disp(Er_W);

% Neural Networks
W = bpxnc(trn,2,1000); 

%The Nonlinear Support Vector Machine
[W J] = svc(trn,kernel);

%Decision Tree
W = treec(A,CRIT,PRUNE,T);

%Cluster
[P,lab,WS] = kmclust(trn,1,false,false);

%Is Classifier Combination Needed(???)

%Cross Validation
[ERR,CERR,NLAB_OUT] = prcrossval(A,CLASSF,NFOLD,1,TESTFUN);


%Error Bar (Or just show the error rate?)
AllWS = zeros(10,1);
alldata = zeros(9,1);
err = zeros(9,1);
for j = 1:10
    for i = 1:10 
        [P,lab,WS] = kmclust(a,g(j),false,false);
        AllWS(i) = WS;
    end
   
    AllWS = AllWS/ mean(AllWS1);
    alldata(j) = mean(AllWS);
    err(j) = std(AllWS);
end
errorbar(g,alldata,err,'r');
