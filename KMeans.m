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

[A,B,Layers] = size(featureImageIn);
Clusters = numberofClusters;
P = featureImageIn;

% Interation Time
Interation=0;
Max_Interation=100;

% Create Class Layer
R = zeros(A,B,2);

% Pick Centers
if (nargin == 3) && (~isempty(clusterCentersIn))
    Q = clusterCentersIn';
else
    Q = zeros(Layers,Clusters);
    for i = 1:Layers
        for j = 1:Clusters
            X = randi(A);
            Y = randi(B);
            Q(i,j) = P(X,Y,i);
        end
    end
end

% Interation
while Interation<4
    
    Interation=Interation+1;
    
    % Distance Calculation & Classification
    for i = 1:A
        for j = 1:B
            for l = 1:Clusters
                P1=reshape(P(i,j,:),[Layers,1]);
                Q1=Q(:,l);
                D(l) = pdist2(P1',Q1','squaredeuclidean');
            end
            [~,Index] = min(D(:));
            R(i,j,1) = Index;
        end
    end
    
    % Update Centers
    for l = 1:Clusters
        Sum=zeros(Layers,1);
        Num=0;
        for i = 1:A
            for j = 1:B
                if R(i,j,1) == l
                    P1=reshape(P(i,j,:),[Layers,1]);
                    Sum=Sum+P1;
                    Num=Num+1;
                end
                Avg=Sum/Num;
                Q(:,l) = Avg;
            end
        end
    end
    
    % Check & Transfer
    if R(:,:,2) == R(:,:,1); break
    else R(:,:,2) = R(:,:,1);
    end
end

% % Cost Function
% % Total Distance¡úT
% T=0;
% for i = 1:A
%     for j = 1:B
%         for l = 1:Clusters
%             if R (i,j,1) == l
%                 P1=reshape(P(i,j,:),[Layers,1]);
%                 Q1=Q(:,l);
%                 T = T+ pdist2(P1',Q1','squaredeuclidean');
%             end
%         end
%     end
% end

% Final Output
segmentedImage=R(:,:,1);
segmentedImage=segmentedImage/Clusters;
