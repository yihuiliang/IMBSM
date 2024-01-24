function   FB_pairs= gprmode(fitness,x_sample,n,numelf,numelb,FB_s)
[fitness,ind]=sort(fitness,'ascend');


%fitness=prob(fitness(n));
%% fit
gprMdl = fitrgp(x_sample(ind(n),:),fitness(n));
fun=@(x)predict(gprMdl,x);
[~,ind]=min(fun(FB_s));
FB_pairs=fmincon(fun,FB_s(ind,:),[],[],[],[],[1 1],[numelf numelb],[],optimoptions(@fmincon,'Display', 'off'));
FB_pairs=round(FB_pairs);



