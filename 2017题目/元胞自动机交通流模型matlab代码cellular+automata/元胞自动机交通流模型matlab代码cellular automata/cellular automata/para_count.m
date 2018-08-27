function [v,gap,LUP,LDOWN]=para_count(plaza,v,vmax);
    [L,W]=size(plaza);%������С�������߽�
    %step1:ÿ������Ϊ�˴ﵽԤ������ٶȵ�ʱ���һ�����ڼ�һ���ٶ�
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)==1); 
        for k=1:length(temp)
            i=temp(k);
            v(i,lanes)=min(v(i,lanes)+1,vmax(i,lanes));
        end
    end
    %step2:����ÿ������ǰ��һ�����ľ���gap
    gap=zeros(L,W);
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)==1);
        nn=length(temp);%�ó����ĳ�������
        for k=1:nn;
            i=temp(k);
            if(k==nn)
                gap(i,lanes)=L-(temp(k)-temp(1)+1);%Ϊ���ڱ߽�ѭ��Ԥ����ĳ���
                continue;
            end
            gap(i,lanes)=temp(k+1)-temp(k)-1;
        end
    end
%     for i=1:L;
%         for j=1:W;
%             if(plaza(i,j)~=1)
%                     gap(i,j)=-88;
%             end
%         end
%     end
%     gap

    %step3:����ÿ���󳵵���ǰ�󳵵ľ����Ƿ���Ҫ��Χ��
    LUP=zeros(L,W);
    LDOWN=zeros(L,W);
    for lanes=2:W-2;
        temp=find(plaza(:,lanes)==1);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            LDOWN(i,lanes)=(plaza(mod(i-2,L)+1,lanes+1)==0);
            if(k==nn)
                if(sum(plaza([i:L],lanes+1))==0 & sum(plaza([1:mod(i+gap(i,lanes),L)+1],lanes+1))==0)
                    LUP(i,lanes)=1;
                end
                continue;
            end
            if(sum(plaza([i:i+gap(i,lanes)+1],lanes+1))==0)
                LUP(i,lanes)=1;
            end
        end
    end
%     for i=1:L;
%         for j=1:W;
%             if(plaza(i,j)~=1)
%                     LUP(i,j)=-88;
%             end
%         end
%     end
%     LUP
end