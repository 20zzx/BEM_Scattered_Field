function [eq] = qiuzhixian(varargin)%��ͨ��һ��bai������du��ֱ��
%%%%ʹ�÷�����qiujzhixian([2 3]),qiujuli([2 3],[4 5]),
x1=varargin{1}{1};
x2=varargin{1}{2};
p=polyfit([x1(1) x2(1)],[x1(2) x2(2)],1);
hold on;
eq=poly2sym(p);
%disp(['���������㣬����ͨ���������ֱ�߷���Ϊ��y = ' char(eq)])
end

