function alpha = IMBSM_matting(img,trimap,MFE)
sample_size = MFE;
X_e = 1:MFE;
[F_ind,B_ind,U_ind,F_rgb,B_rgb,U_rgb,F_s,B_s,U_s,~,~] = GetMattingInfo(img,trimap);
FB_pairs=zeros(length(U_ind),2);
U_dist = bwdist(trimap == 128);
F_dist = U_dist(F_ind);F_dist_ind = F_dist<2;
B_dist = U_dist(B_ind);B_dist_ind = B_dist<2;
UF = F_s(F_dist_ind,:);
UB = B_s(B_dist_ind,:);
map = zeros(size(trimap));
numelf = length(F_ind);
numelb = length(B_ind);
map(F_ind) = 1:numelf;
map(B_ind) = 1:numelb;

%%  random sampling
x_sample = [];
x_sample(:,1)=round(1+(length(F_rgb(:,1))-1).*rand(sample_size,1));
x_sample(:,2)=round(1+(length(B_rgb(:,1))-1).*rand(sample_size,1));
parfor n = 1:length(U_ind)
    U_rgb_sample=U_rgb(n,:);
    U_s_sample=U_s(n,:);
    FB_s = nhood(3,U_s_sample,UF,UB,map);
    fitness=CostFunc(x_sample,F_rgb,B_rgb,U_rgb_sample);
    %% GPR surrogate models
    FB_pairs(n,:)= gprmode(fitness,x_sample,X_e,numelf,numelb,FB_s);
end

%% FB_pair to alpha
[alpha,~] = FB2alpha(FB_pairs,img,trimap,0);
end
