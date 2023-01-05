%ZeroOneTEST Gottwald墨尔本0-1混沌测试复现载入代码
%2022/08/23 by Lin Yiting.

clear;clc;close all; 

AA=[
    0.6500    0.1500   -0.1500
    0.3300    0.4700   -0.3300
    0.1800    -0.1800  0.3200
   ];

E=8*10^12;B=2*10^12;
E1=E;E2=E;E3=E;   
B1=B;B2=B;B3=B;
E=E1+E2+E3;B=B1+B2+B3;
X1(1)=0.1;
X2(1)=0;
X3(1)=0.3;

M=200;
for i=1:1000

      for k=1:M 	  
       X1(k+1) = AA(1,1)*X1(k) +AA(1,2)*X2(k) +AA(1,3)*X3(k) +mod(B1*X1(k),E1);
       X2(k+1) = AA(2,1)*X1(k) +AA(2,2)*X2(k) +AA(2,3)*X3(k) +mod(B2*X2(k),E2);
       X3(k+1) = AA(3,1)*X1(k) +AA(3,2)*X2(k) +AA(3,3)*X3(k) +mod(B3*X3(k),E3);
      end
      p1=X2;
      out(i)=ZeroOneTEST(p1);
      X2(1)=X2(1)+0.001;
end

x(1)=0;
for i=1:999
    x(i+1)=x(i)+0.001;
end
all=0;
for i=1:1000
    all=all+out(i);
end
all=all/1000

for i=1:1000
    allout(i)=all;
end

figure(1)
%plot();hoid on;
plot(x,out,x,allout);xlabel('X');ylabel('K')
