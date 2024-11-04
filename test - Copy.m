%% Simultaneously dictionary learning and denoising for seismic data
% Author: F. Bossmann
% Reference:
% S. Beckouche, J. Ma*, Simultaneously dictionary learning and denoising for seismic data, Geophysics, 2014, 79 (3), A27-A31.
% Email:jma@hit.edu.cn
% April 11st, 2017

%%
clf reset
clc
clear all;
close all;
echo off
options.sparse_coding = 'omp_err';
% options.sparse_coding = 'omp';
options.manual=1;
%options.dico_sigm = sigma;
options.centerize = 0;
options.centerize_den = 0;
options.q=1;
options.linearis=0
%options.w=8;%defaul 9

%load X_elf3D;
%M0=X_elf3D(1:256,1:256); clear X_elf3D;
load X1

M0=X1(101:356,101:356);
M0=M0/max(M0(:));
level=0.2;
noisy3=level*randn(size(M0));
save noisy3.mat noisy3
load noisy3
M= M0 + noisy3;
%options.sigm2=MAD(M(:));
SNR_noisy=SNR(M0,M)
MSE_noisy=immse(M,M0)
subplot(3,4,1),imagesc(M0), colormap(jet);
xlabel('Trace number');
ylabel('Time sampling number');
title('(a) original data');
subplot(3,4,2); imagesc(M),colormap(jet);
xlabel('Trace number');
ylabel('Time sampling number');
title('(b) noisy data');
load itertest1
% load sparsity1
subplot(3,4,3); imagesc(itertest1),colormap(jet);
xlabel('Trace number');
ylabel('Time sampling number');
 title('(c) denoised data for iteration test1');
 load  itertest2
%  load sparsity2
subplot(3,4,4); imagesc(itertest2),colormap(jet);
xlabel('Trace number');
ylabel('Time sampling number');
 title('(d) denoised data for iteration test2');
load itertest3
subplot(3,4,5); imagesc(itertest3),colormap(jet);
xlabel('Trace number');
ylabel('Time sampling number');
 title('(e) denoised data for iteration test3');
 load itertest4
 subplot(3,4,6); imagesc(itertest4),colormap(jet);
xlabel('Trace number');
ylabel('Time sampling number');
 title('(f) denoised data for iteration test4');
 load itertest5
 subplot(3,4,7); imagesc(itertest5),colormap(jet);
 xlabel('Trace number');
ylabel('Time sampling number');
 title('(g) denoised data for iteration test5');
 load itertest6
 subplot(3,4,8); imagesc(itertest6),colormap(jet);
 xlabel('Trace number');
ylabel('Time sampling number');
 title('(h) denoised data for iteration test6');
 load itertest7
 subplot(3,4,9); imagesc(itertest7),colormap(jet);
 xlabel('Trace number');
ylabel('Time sampling number');
 title('(i) denoised data for iteration test7');
% load patchsize3
% load testmad
% subplot(2,3,3); imagesc(testmad),colormap(jet);
% xlabel('Trace number');
% ylabel('Time sampling number');
% % title('(c) denoised data for patch size 3');
%  title('(c) denoised data for threshold estimated with MAD');
% 
% % load patchsize8
% load testmadscaled
%  subplot(2,3,4); imagesc(patchsize8),colormap(jet);
% subplot(2,3,4); imagesc(testmadscaled),colormap(jet);
% xlabel('Trace number');
% ylabel('Time sampling number');
%  title('(d) denoised data for patch size 8');
% title('(d) denoised data for threshold estimated using scaled MAD');
% 
% load patchsize9
% subplot(2,3,5); imagesc(patchsize9),colormap(jet);
% xlabel('Trace number');
% ylabel('Time sampling number');
% title('(e) denoised data for patch size 9');

% figure, imagesc(M0), colormap(gray);
% figure, imagesc(M), colormap(gray);

for i=1:4
 tic
[D1,X] = perform_dictionary_learning(M,options);
%load D1;
%figure, imagesc(D1), colormap(gray);

M = perform_dictionary_denoising(M,D1,options);

toc
subplot(3,4,10); imagesc(M),colormap(jet);
xlabel('Trace number');
ylabel('Time sampling number');
title('(j) denoised data for iteration test8');
%title('(d) denoised data for patch size 10');
% title('(e) denoised data for threshold estimated using RS');
%figure, imagesc(M), colormap(gray);
SNR_denoised=SNR(M0,M)
MSE_denoised=immse(M,M0)
M0=M;
%%%%%%%%%%%%%%%%%%%%%%%%
[n1,n2]=size(D1)
H0=zeros(3,12);
L0=zeros(9,3);
B=[];
k=0;
for j=1:10:160
    k=k+1;
    A=reshape(D1(:,j),sqrt(n1),sqrt(n1));A=[A,L0];A=[A;H0];
    B=[B,A];
end
 C=[B(:,1:48);B(:,49:96);B(:,97:144);B(:,145:192)];
figure, imagesc(C(1:45,1:45)), colormap(gray);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n1,n2]=size(D1)
H0=zeros(3,12);
L0=zeros(9,3);
B=[];
k=0;
for j=1:6:150
    k=k+1;
    A=reshape(D1(:,j),sqrt(n1),sqrt(n1));A=[A,L0];A=[A;H0];
    B=[B,A];
end
 C=[B(:,1:60);B(:,61:120);B(:,121:180);B(:,181:240);B(:,241:300)];
figure, imagesc(C(1:57,1:57)), colormap(gray);
end