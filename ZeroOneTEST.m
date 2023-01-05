%ZeroOneTEST Gottwald墨尔本0-1混沌测试复现
%The code modification and reconstruction came from Lin Yiting.
%ZeroOneTEST（X）是应用于向量X的0-1测试的结果。
%结果对于非混沌数据接近0，对于混沌数据接近1。
%看http://arxiv.org/pdf/0906.1418v1.保罗·马修斯，2009年7月。

function out=ZeroOneTEST(x)
%Warning=0;
s=size(x); if s(2)==1; x=x'; end;
N=length(x); j=[1:N];
t=[1:round(N/10)];
M=zeros(1,round(N/10));
c=pi/5+rand(1,100)*3*pi/5;  % 100 random c values in [pi/5,4pi/5]
for its=1:100
   p=cumsum(x.*cos(j*c(its)));q=cumsum(x.*sin(j*c(its)));
   for n=1:round(N/10); 
      M(n)=mean( (p(n+1:N)-p(1:N-n)).^2 + (q(n+1:N)-q(1:N-n)).^2 )- ...
           mean(x)^2*(1-cos(n*c(its)))/(1-cos(c(its)));
   end
   kcorr(its)=corr(t',M');
end
%plot(c,kcorr,'*');xlabel('c');ylabel('k'); % 有用的诊断图
  %plot(t,M);xlabel('t');ylabel('M')
% 检查过采样的两次粗略尝试:
if (max(x)-min(x) )/mean(abs(diff(x))) > 10 | ...
       median(kcorr(c<mean(c))) - median(kcorr(c>mean(c))) > 0.5
   disp('警告：数据可能过采样。')%使用更粗的采样或减小 c 的最大值。
end

out=median(kcorr);
end