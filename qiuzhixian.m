function [eq] = qiuzhixian(varargin)%求通过一点bai或两点du的直线
%%%%使用方法：qiujzhixian([2 3]),qiujuli([2 3],[4 5]),
x1=varargin{1}{1};
x2=varargin{1}{2};
p=polyfit([x1(1) x2(1)],[x1(2) x2(2)],1);
hold on;
eq=poly2sym(p);
%disp(['输入有两点，则求通过这两点的直线方程为：y = ' char(eq)])
end

