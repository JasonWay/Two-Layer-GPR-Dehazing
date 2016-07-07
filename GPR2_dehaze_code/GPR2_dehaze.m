function GPR2_dehaze()
clear all
I0=imread('Haze0_7.jpg');
I = im2double(I0);
[seg Sp Sp2]=super_pixels(I); %�����طָ�
% Sp2=importdata('hazyimage1_Seg3.mat');
H_gabor=feature_vector(I0, Sp2); %��ȡ��������
% H_gabor=importdata('hazyimage1_gabor.mat');
[pre_tran1 pre_var1]=first_regression(H_gabor);%��һ��ع�
[local_stru local_var]=trans_smooth(I0,pre_tran1,Sp2,pre_var1);%��͸���ʽ��г���ƽ����ת��Ϊ����������ع����������
[pre_trans2 pre_var2]=second_regression(local_stru);%�ڶ���ع�
[pre_y1,pre_y2,variance_y1,variance_y2]=gettrans(local_stru,local_var,pre_trans2,pre_var2);
pre_trans2=product(pre_y1,pre_y2,variance_y1,variance_y2,pre_trans2);%�˻�
haze_filtering(pre_trans2,I0);%������Ч�˲�

