% GP_2d.m

% ѡ��˺���(Э�����)�����ֵ����Ĭ��Ϊ����0.
kernel = 1;
switch kernel
    case 1; k = @(x,y) 1*x'*y; %Linear
    case 2; k = @(x,y) exp(-100*(x-y)'*(x-y)); %squared exponential
    case 3; k = @(x,y) exp(-1*sqrt((x-y)'*(x-y))); %Ornstein-Uhlenbeck
end

% ѡ������ʾ�ĵ�points����ά��
points = (0:0.02:1)';
[U,V] = meshgrid(points,points);
x = [U(:) V(:)]';
n = size(x,2);

% ����Э�������
C = zeros(n,n);
for i = 1:n
    for j = 1:n
        C(i,j) = k(x(:,i),x(:,j));
    end
end

% ��GP���в���
rn = randn(n,1);%����n��0~1֮��������,������̬�ֲ�
[u,s,v] = svd(C); %svd�ֽ�rn����sΪ����ֵ����uΪ��������.C=usv'
z = u*sqrt(s)*rn; %zΪʲô��ô��ʾ,�����ǣ���

% ����GP��һ��sample
figure(2); clf
Z = reshape(z,sqrt(n),sqrt(n));
surf(U,V,Z);