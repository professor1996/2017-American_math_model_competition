%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A Two-Lane Cellular Automaton Traffic Flow Model with the Keep-Right Rule
%edited by Milky Zhang,Image Information Institute in Sichuan Universiyt 2014/2/14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

B=2;             %The number of the lanes
plazalength=50;  %The length of the simulating highways
h=NaN;           %h is the handle of the image


[plaza,v]=create_plaza(B,plazalength);
h=show_plaza(plaza,h,0.1);

iterations=1000;    % ��������
probc=0.1;          % �������ܶ�
probv=[0.1 1];      % ���ֳ������ܶȷֲ�
probslow=0.3;       % ��������ĸ���
Dsafe=1;            % ��ʾ�����³���������泵������ٸ���λ���㰲ȫ
VTypes=[1,2];       %��·��һ���м�������ٶȲ�ͬ�ĳ���,�ٶ���ʲô
[plaza,v,vmax]=new_cars(plaza,v,probc,probv,VTypes);%һ��ʼ���ڳ����ϲ��ó�����������ѭ����ʻ��Ҳ����۲������ܶ�֮��Ĺ�ϵ

size(find(plaza==1))
PLAZA=rot90(plaza,2);
h=show_plaza(PLAZA,h,0.1);
for t=1:iterations;
    size(find(plaza==1))
    PLAZA=rot90(plaza,2);
    h=show_plaza(PLAZA,h,0.1);
    [v,gap,LUP,LDOWN]=para_count(plaza,v,vmax);
    [plaza,v,vmax]=switch_lane(plaza,v,vmax,gap,LUP,LDOWN);
    [plaza,v,vmax]=random_slow(plaza,v,vmax,probslow);
    [plaza,v,vmax]=move_forward(plaza,v,vmax);
end




