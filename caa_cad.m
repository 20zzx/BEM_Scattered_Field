clc;
clear;
close All;

frequency = 3*10e9; %Ƶ��3 GHz
c = 3*10e8;
k = 1/(c/frequency);
num_line = 20;
boundary_line = [];
middle_point = [];

%����߽�ڵ�
[ax,ay] = plot_polygon(num_line,0.02);
ay(end) = 0;%��������

%����߽�ֱ��
for i=1:(length(ax)-1)
    boundary_line = [boundary_line qiuzhixian({[ax(i),ay(i)],[ax(i+1),ay(i+1)]})]; 
end

%����߽�ԪԴ��
for i=1:(length(ax)-1)
    middle_point = [middle_point;([ax(i),ay(i)]+[ax(i+1),ay(i+1)])/2];
end
scatter(middle_point(:,1),middle_point(:,2),'+');

%��߽緽����
G = zeros(num_line,num_line);
syms x y;
for m = 1:num_line
    for n = 1:num_line
        %y = boundary_line(n);
        juli = k*norm(middle_point(n,:)-[x,boundary_line(m)]);
        hker = besselj(0,juli)-1i*bessely(0,juli);
        f = @(x)(1/4i)*hker*(k*array_model(middle_point(n,:)-[x,boundary_line(m)]));
        fprintf('%d %d \n',n,m);
        g = int(f,x,ax(n),ax(n+1));
        G(n,m) = double(g);
    end
end



