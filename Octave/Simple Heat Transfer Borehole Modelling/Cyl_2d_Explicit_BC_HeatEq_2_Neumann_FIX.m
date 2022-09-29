clear
clc
clf

alpha = 1e-4;           % Heat Conduction constant
r_in=0.1;               % deepest radius
r_out=1;                % outermost radius
m=9;                    % number of discretization
delta_r=(r_out-r_in)/m; % delta radius
nr = m+1;               % discretization of radius except the middle

t=900;                  % Final time
nt=30;                  % discretization of time
delta_t=t/nt;           % delta time

Trin=300;               % initial heat in the deepest radius
Trout=0;                % initial heat in the outermost radius
Tin=0;                  % initial heat beetwee the deepest radius and the outermost radius

fluks= -100;            % If the boundary is Neumann
bc = nr                 % Where's the Neumann Boundary (middle(1)/outside(nr))

Tmax = max([Trin,Trout]);

%solution

for i = 1:nr
  r(i) = r_in + (i-1)*delta_r;
 endfor
 
r;

delta_phideg = 10;                 % delta each angle in degrees
phideg= [0:delta_phideg:360];
phi = phideg.*pi/180;
nphi=length(phi);                  % discretization of the angle
delta_phi = delta_phideg*pi/180;

d = alpha*delta_t/delta_r^2; %diffusion number
d1= alpha*delta_t/(2*delta_r);

##if d<0.5
##  fprintf('solution stable\nd=%10.7f\n',d)
##else
##  fprintf('solution unstable\nd=%10.7f\n',d)
##end
##  

%creating initial and boundary conditions
T=zeros(nr,nphi,nt);

for k=1:nt+1
  for j =1:nphi
    for i =1:nr
     if(i==1)
        T(i,j,k) = Trin;
       elseif(i==nr)
        T(i,j,k) = Trout;
       else 
        T(i,j,k) = Tin;
       end
     end
    end
end


%Heat Equation
for k = 1:nt
  for j = 1:nphi
    for i = 2:nr
     if(i==nr)
     T(i,j,k+1) = T(i-1,j,k)+fluks*delta_r;
     else
     T(i,j,k+1) = T(i,j,k)+d*(T(i+1,j,k)-2*T(i,j,k)+T(i-1,j,k))+d1/r(i)*(T(i+1,j,k)-T(i-1,j,k));
     end 
    end
  end
end

%adding row in the middle radius.
r_end=[ones(size(r, 1),1) r];
r_end(1)=0;   %the middle radius is r=0.

T_center = T(1,:,:);
T=[T(1:0,:,:);T_center;T(0+1:end,:,:)]; %Heat condition in the middle radius.

%Plotting

T1=T(:,:,1);
subplot(2,3,1)
r=r;
[Phi,R]=meshgrid(phi,r_end);
Z=T1;
[X,Y,Z]=pol2cart(Phi,R,Z);

[C,h]=contourf(X,Y,Z,300);
set(h,'LineColor','none')
grid on
axis equal
colorbar
title({'Initial Temperature Profile';'T in deg.C/'})
xlabel(['r in m'])

T2=T(:,:,nt+1);
subplot(2,3,4)
r=r;
[Phi,R]=meshgrid(phi,r_end);
Z=T2;
[X,Y,Z]=pol2cart(Phi,R,Z);

[C,h]=contourf(X,Y,Z,300);
set(h,'LineColor','none')
grid on
axis equal
colorbar
title({'Final Temperature Profile';'T in deg.C/'})
xlabel(['r in m'])

r;
phi;
[R PHI]=meshgrid(r_end,phi+1);
Z=T(:,:,1);

for k =1:nt+1
  Z=Z';
  subplot(2,3,5)
  h = contourf(R.*cos(PHI),R.*sin(PHI),Z);
  colorbar;
  shading interp;
  title({['Transient Heat Conduction - Contour Profile'];['time(\itt)=',num2str((k-1)*delta_t),'s']})
drawnow;
pause(0.005);
  subplot(1,3,3)
  h1 = surf(R.*cos(PHI),R.*sin(PHI),Z);
  colorbar;
  shading interp;
  title({['Transient Heat Conduction -  Surface Profile'];['time(\itt)=',num2str((k-1)*delta_t),'s']})
drawnow;
pause(0.005);

##filename=sprintf('%d.jpg',(k-1)*delta_t);
##   print(filename);

if k~=nt+1
  Z=T(:,:,k+1);
else
  break;
end

endfor

# Source : 
# https://www.mathworks.com/matlabcentral/answers/172699-how-can-i-insert-row-into-matrix-without-deleting-its-values
# https://engineering-stream.com/Numerical_Methods_Codes.html