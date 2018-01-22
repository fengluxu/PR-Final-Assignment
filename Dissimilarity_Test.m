a1 = prnist([0:9],[1:1000]);
b1 = my_rep1(a1);
classifier = {knnc([],1),knnc([],2),knnc([],3),nmc,ldc,fisherc,loglc};
mapping = proxm(b1,'d',1);

%%
    w = b1* mapping * logmlc;
    w = mapping * w;
    total_err = nist_eval('my_rep1',w,100);
    disp('logmlc');
    disp(total_err);

%%
%city block
a = prnist([0:9],[1:1000]);
b = my_rep1(a);
mapping = proxm(b,'c',1);

%%
w = b*mapping*ldc;
w = mapping * w;
total_err = nist_eval('my_rep1',w);
disp('ldc');
disp(total_err);
%%
all_err = 0;
classier = perlc;
for i = 1:10
    ran = round(rand(1, 10)*1000);
    c = prnist([0:9],ran);
    d = my_rep1(c);
    mapping = proxm(d,'d',1);
    pca = pcam(d,0.8);
    w1 = d*mapping*classier;
    w1 = mapping * w1;
    err = nist_eval('my_rep1',w1,100);
    disp(err);
    all_err = all_err + err;
    
    ran2 = round(rand(1, 10)*1000);
    c2 = prnist([0:9],ran);
    d2 = my_rep2(c2);
    error = w1*d2*testc;
    disp(error);
end

avg_err = all_err / 10;
disp('average error =');
disp(classier);
disp(avg_err);