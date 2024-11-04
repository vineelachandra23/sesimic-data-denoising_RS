

function [MM]=ENVSM(M)
% M3=Mn;
% Y=reshape(M,512,512);
Y=reshape(M,256,256);
s=0;
  for i=1:256
    M2(:,i)=Y(:,i);
estimated =rs(M2(:,i));
s=s+estimated;
end
avg=s/length(M2);
%sigma=sqrt(avg);
%MM=sigma;
MM=avg;
  %return sigma;