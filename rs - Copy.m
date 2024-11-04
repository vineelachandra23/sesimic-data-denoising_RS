function [MM]=rs(Mn)
M1=Mn;
aa=conv(M1,[2 0 -2 0]/sqrt(8));
i=1:length(M1)/4;
v=aa(4*i+0);
med=median(abs(v-median(v)));
MM=med/.6745;
