clear all
clc

x = linspace(0,3,4);
y = linspace(0,7,8);

[X,Y] = meshgrid(x,y);
m = length(x);
n = length(y);

DELX=0.01;
DELY=0.01;
L = (n)*(m-2);

A=-4;
B(1:L)=1;
C(1:L)=1;
D(1:L)=1;
E(1:L)=1;

AA = eye(L).*A;
AA1=diag(E(1:L-m+2),m-2);
AA2=diag(D(1:L-m+2),-(m-2));
ii=(1:n-3)*(m-2);
#jj=ii+1;
jj=ii;
C(jj)=0;
B(ii)=0;
AA3=diag(C(1:L-1),-1);
AA3(13,12)=0;
AA3(15,14)=0;
AA4=diag(B(1:L-1),1);
AA4(12,13)=0;
AA4(14,15)=0;
AAA=AA+AA1+AA2+AA3+AA4;
AAA(2,2)=-3;
AAA(1,1)=-3;
AAA(15,15)=-3;
AAA(16,16)=-3;

BB(1:L)=51.25;        #(K + Flux* Deltax)
BB(1:2)=66.25;
BB(15:16)=26.25;
BB=BB';
Hasil=-AAA\BB;


#A = AAA;
%b = BB;
%det(A);
%[L,U]=lu(A);
%LUU=inv(U)*inv(L)*b;
%HASIL2=LUU;

U1=reshape(Hasil,m-2,n);
U1=U1';
U=zeros(n,m);
U(1:n,1)=20;
U(1:n,m)=20;
U(1:n,2:3)=U1;
#U(1:n,1:m)=U1;
U = transpose(U);

cmap = jet(256);
colormap(cmap);
subplot(2,1,1);
surf(y,x,U);
title('3D');
colorbar;
subplot(2,1,2);
contourf(y,x,U);
title('2D');
colorbar;
shading interp