% Do not change the function name. You have to write your code here
% you have to submit this function
function segmentedImage = KMeans(featureImageIn, numberofClusters, clusterCentersIn)

% Get the dimensions of the input feature image
[M, N, noF] = size(featureImageIn);
% some initialization
% if no clusterCentersIn or it is empty, randomize the clusterCentersIn
% and run kmeans several times and keep the best one
if (nargin == 3) && (~isempty(clusterCentersIn))
    NofRadomization = 1;
else
    NofRadomization = 5;    % Should be greater than one
end

% ----------------------------------- % 
% -You have to write your code here-- %
% ----------------------------------- % 

maxvalue=zeros(1,noF);
minvalue=zeros(1,noF);

T=featureImageIn;
T1=reshape(T,M*N,noF);
[M1,~]=size(T1);
Ad=zeros(NofRadomization,1);
for mm=1:NofRadomization
    c=zeros(numberofClusters,noF);
    As=0;
    for j=1:noF
        maxvalue(1,j)=max(max(featureImageIn(:,:,j)));
        minvalue(1,j)=min(min(featureImageIn(:,:,j)));
        for i=1:numberofClusters
            c(i,j)=minvalue(1,j)+(maxvalue(1,j)-minvalue(1,j)).*rand();
        end
    end

    cc=c;

    while 1
        
        pre_c=c;
        pos=[];
        Diff=zeros(M1,numberofClusters);
        for k=1:numberofClusters
            for i=1:M1
                Diff(i,k)=norm(T1(i,:)-pre_c(k,:));
            end
        end
        Diff=Diff';
        [~,pos]=min(Diff);
        pos=pos';
        
        
        As=cell(1,numberofClusters);
        
        for i=1:numberofClusters
            As{i}=zeros(1,noF);
        end
        
        counters=ones(1,numberofClusters);
        
        for i=1:M1
            index=pos(i);
            As{index}(counters(index),:)=T1(i,:);
            counters(index)=counters(index)+1;
        end


        for i=1:numberofClusters
            A=As{i};
            c(i,:)=sum(A)/length(A(:,1));
        end
        
        for i=1:numberofClusters
            if c(i,:)==0
                c(i,:)=cc(i,:);
            else
            end
        end
        
        
        if pre_c==c
            break
        end
    end
    
    for i=1:M1
        a=Diff(pos(i),i);
        Ad(mm,:)= Ad(mm,:)+a;
        Ap(mm,:)=pos;
    end
end

[~,L]=min(Ad);
pos=Ap(L,:)';
segmentedImage1=[];

% B=(~any(A1(:)))+(~any(A2(:)))+(~any(A3(:)))+(~any(A4(:)))+(~any(A5(:)))+(~any(A6(:)))+(~any(A7(:)))+(~any(A8(:)));
B=(~any(As{1}(:)))+(~any(As{2}(:)))+(~any(As{3}(:)))+(~any(As{4}(:)))+(~any(As{5}(:)))+(~any(As{6}(:)))+(~any(As{7}(:)))+(~any(As{8}(:)));

L=(max(maxvalue)-min(minvalue))/(numberofClusters-B-1);

segmentedImage1=pos./numberofClusters;
% for i=1:M1
%     if pos(i)==1
%         segmentedImage1(i)=L*(any(As{1}(:))-1);    %Diff(pos(i),i);
%     elseif pos(i)==2
%         segmentedImage1(i)=L*((any(As{1}(:)))+(any(As{2}(:)))-1);
%     elseif pos(i)==3
%         segmentedImage1(i)=L*((any(As{1}(:)))+(any(As{2}(:)))+(any(As{3}(:)))-1);
%     elseif pos(i)==4
%         segmentedImage1(i)=L*((any(As{1}(:)))+(any(As{2}(:)))+(any(As{3}(:)))+(any(As{4}(:)))-1);
%     elseif pos(i)==5
%         segmentedImage1(i)=L*((any(As{1}(:)))+(any(As{2}(:)))+(any(As{3}(:)))+(any(As{4}(:)))+(any(As{5}(:)))-1);
%     elseif pos(i)==6
%         segmentedImage1(i)=L*((any(As{1}(:)))+(any(As{2}(:)))+(any(As{3}(:)))+(any(As{4}(:)))+(any(As{5}(:)))+(any(As{6}(:)))-1);
%     elseif pos(i)==7
%         segmentedImage1(i)=L*((any(As{1}(:)))+(any(As{2}(:)))+(any(As{3}(:)))+(any(As{4}(:)))+(any(As{5}(:)))+(any(As{6}(:)))+(any(As{7}(:)))-1);
%     elseif pos(i)==8
%         segmentedImage1(i)=L*((any(As{1}(:)))+(any(As{2}(:)))+(any(As{3}(:)))+(any(As{4}(:)))+(any(As{5}(:)))+(any(As{6}(:)))+(any(As{7}(:)))+(any(As{8}(:)))-1);
%     end
% end

segmentedImage1=segmentedImage1';
segmentedImage=reshape(segmentedImage1,M,N);