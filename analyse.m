clc;
clear;
close All;

frequency = 3*10e9; %频率3 GHz
c = 3*10e8;
k = 1/(c/frequency);
num_line = 20;
boundary_line = [];
middle_point = [];
[ax,ay] = plot_polygon(num_line,0.02);
ay(end) = 0;%修正复数
load 'G20_60'

%计算边界元
for i=1:(length(ax)-1)
    boundary_line = [boundary_line qiuzhixian({[ax(i),ay(i)],[ax(i+1),ay(i+1)]})]; 
end

%计算边界元源点
for i=1:(length(ax)-1)
    middle_point = [middle_point;([ax(i),ay(i)]+[ax(i+1),ay(i+1)])/2];
end
scatter(middle_point(:,1),middle_point(:,2),'+');

mode = 2;

if mode ==1
    %求解边界方程组
    % syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
    % b = [x1;x2;x3;x4;x5;x6;x7;x8;x9;x10;x11;x12;x13;x14;x15;x16;x17;x18;x19;x20];
    E = repmat([1,1i],20,1);
    %E = zeros(20,1)+1;
    b = linsolve(G,E);
    
    syms m n x y
    Z = zeros(20,2);
    for p=1:20
        for i=1:20
                y = boundary_line(i);
                m=ax(i);
                n=ay(i);
                f = (1/4i)*bessely(0,m)*(k*array_model([m,n]-[x,y]))*b(i,:);
                g = int(f,x,ax(i),ax(i+1));
                z = double(g);
                % r = solve(g==1,x);
                Z(p,1) = Z(p,1)+z(1);
                Z(p,2) = Z(p,2)+z(2);
        end
        disp(p);
    end
else
    E = zeros(20,1)+1;%E = zeros(20,1)+1;
    b = linsolve(G,E);
    
    %{
    Z = [];
    for i = 1:20
        Z = [Z;abs(b(i))];
    end
    figure
    plot(1:20,Z);
    %}
    
    hold off;
    figure;
    syms m n x y
    Z = zeros(11,11);
    [X,Y] =  meshgrid([-0.1:0.02:0.1,0.1:0.02:-0.1]);
    for p=1:11
        for q=1:11
            m=X(1,p);
            n=Y(q,1);
            for i=1:20
                    y = boundary_line(i);
                    juli = k*norm([m,n]-[x,y]);
                    hker = besselj(0,juli)-1i*bessely(0,juli);
                    f = (1/4i)*hker*(k*array_model([m,n]-[x,y]))*b(i);
                    g = int(f,x,ax(i),ax(i+1));
                    z = double(g);
                    if isnan(z) 
                        z = 0;
                    end
                    % r = solve(g==1,x);
                    Z(p,q) = Z(p,q)+z;
            end
            fprintf('%d %d \n',p,q);
        end
    end
end



%{
Z = [];
for i = 1:20
    x = abs(b(i,1));
    y = abs(b(i,2));
    Z = [Z;array_model([x,y])];
end
figure
plot(1:20,Z);
%带入散射函数
%}


%{
[X,Y] = meshgrid(-10:0.5:10,-10:0.5:10);
Z = zeros(41,41,2);
syms m n x y
for p=1:41
    for q=1:41
        for i=1:20
        y = boundary_line(i);
        m=X(p,q);
        n=Y(p,q);
        f = (1/4i)*bessely(0,m)*(k*array_model([m,n]-[x,y]))*b(i,:);
        g = int(f,x,ax(i),ax(i+1));
        z = double(g);
        % r = solve(g==1,x);
        Z(p,q) = Z(p,q,1)+z(1);
        end
    end
end
%}
    





