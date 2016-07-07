% GP_1d.m

% ѡ��˺���(Э�����)�����ֵ����Ĭ��Ϊ����0.
kernel = 6;
switch kernel
    case 1; k = @(x,y) 1*x'*y; %Linear
    case 2; k = @(x,y) 1*min(x,y); % Brownian  
    case 3; k = @(x,y) exp(-100*(x-y)'*(x-y)); %squared exponential
    case 4; k = @(x,y) exp(-1*sqrt((x-y)'*(x-y))); %Ornstein-Uhlenbeck
    case 5; k = @(x,y) exp(-1*sin(5*pi*(x-y)).^2); %A periodic GP
    case 6; k = @(x,y) exp(-100*min(abs(x-y),abs(x+y)).^2); %A symmetric GP
end

% ѡ������ʾ�ĵ�x��������S��һ����
x = (-1:0.005:1);
n = length(x);

% ����Э�������
C = zeros(n,n);
for i = 1:n
    for j = 1:n
        C(i,j) = k(x(i),x(j));
    end
end

% ��GP���в���
rn = randn(n,1);%����n��0~1֮��������,������̬�ֲ�
[u,s,v] = svd(C); %svd�ֽ�rn����sΪ����ֵ����uΪ��������.C=usv'
z = u*sqrt(s)*rn; %zΪʲô��ô��ʾ,�����ǣ���

% ����GP��һ��sample
figure(1);hold on; clf
plot(x,z,'.-');
% axis([0,1,-2,2]);