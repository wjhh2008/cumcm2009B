cd C:\Users\wjh\Documents\百度云\iMake\竞赛\数模\cumcm2009B
num=[55 72 82 39 101];
load('out.mat');
load('chart.mat');
load('wait.mat');
load('level.mat');
load('time2.mat');
%day
n=300;
block=zeros(n+100,1);

catn=79;
for i=1:79
    ty=chart(i,1);
    outtime=out(ty,randi(num(ty)));
    chart(i,5)=outtime+chart(i,4);
    block(chart(i,5))=block(chart(i,5))+1;
end

lambda=[1.018 1.6 2.216	1.054 2.703];
prd=zeros(n,5);

for i=1:5
    prd(:,i)=poissrnd(lambda(i),n,1);
end

m=0;
for day=73:n
    weekday=mod(1+day,7)+1;
    
    %上床
    u=block(day);
    for i=1:u
        ty=wait(i,1);
        opertime=time2(ty,weekday)+day;
        outtime=out(ty,randi(num(ty)))+opertime;
        block(outtime)=block(outtime)+1;
        chart(catn+1,:)=[wait(i,:) day opertime outtime];
        catn=catn+1;
        wait(i,:)=[];
    end
    %排队+
    add=[];
    for ty=1:5
        for j=1:prd(day,ty)
            add=[add;ty day];
        end
    end
    wait=[wait;add];
end





