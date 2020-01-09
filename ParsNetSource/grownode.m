function [FlexNetwork] = grownode(FlexNetwork,nCluster,winninglayer,k)
%% check current layer weight
[nNode,nCol] = size(FlexNetwork.W{winninglayer});
[nClass,~] = size(FlexNetwork.Ws{1});
nNode = nNode + nCluster;

FlexNetwork.W{winninglayer}   = [FlexNetwork.W{winninglayer};...
    normrnd(0,sqrt(2/(nCol)),[nCluster,nCol])];
FlexNetwork.vW{winninglayer}  = [FlexNetwork.vW{winninglayer};...
    zeros(nCluster,nCol)];
FlexNetwork.dW{winninglayer}  = [FlexNetwork.dW{winninglayer};...
    zeros(nCluster,nCol)];
FlexNetwork.Ws{winninglayer}  = [FlexNetwork.Ws{winninglayer}...
    normrnd(0,sqrt(2/(nNode+1)),[nClass,nCluster])];
FlexNetwork.vWs{winninglayer} = [FlexNetwork.vWs{winninglayer}...
    zeros(nClass,nCluster)];
FlexNetwork.dWs{winninglayer} = [FlexNetwork.dWs{winninglayer}...
    zeros(nClass,nCluster)];

FlexNetwork.WPre{winninglayer} = [FlexNetwork.WPre{winninglayer};...
    normrnd(0,sqrt(2/(nCol)),[nCluster,nCol])];
FlexNetwork.deltaW{winninglayer} = [FlexNetwork.deltaW{winninglayer};...
    zeros(nCluster,nCol)];
FlexNetwork.deltaLossW{winninglayer} = [FlexNetwork.deltaLossW{winninglayer};...
    zeros(nCluster,nCol)];
FlexNetwork.sumDeltaLossW{winninglayer} = [FlexNetwork.sumDeltaLossW{winninglayer};...
    zeros(nCluster,nCol)];
FlexNetwork.weightImportanceW{winninglayer} = [FlexNetwork.weightImportanceW{winninglayer};...
    zeros(nCluster,nCol)];

FlexNetwork.WsPre{winninglayer}= [FlexNetwork.WsPre{winninglayer}...
    normrnd(0,sqrt(2/(nNode+1)),[nClass,nCluster])];
FlexNetwork.deltaWs{winninglayer} = [FlexNetwork.deltaWs{winninglayer}...
    zeros(nClass,nCluster)];
FlexNetwork.deltaLossWs{winninglayer} = [FlexNetwork.deltaLossWs{winninglayer}...
    zeros(nClass,nCluster)];
FlexNetwork.sumDeltaLossWs{winninglayer} = [FlexNetwork.sumDeltaLossWs{winninglayer}...
    zeros(nClass,nCluster)];
FlexNetwork.weightImportanceWs{winninglayer} = [FlexNetwork.weightImportanceWs{winninglayer}...
    zeros(nClass,nCluster)];

%% check the next layer weight
if winninglayer < FlexNetwork.nHiddenLayer
    [wNext,~]                      = size(FlexNetwork.W{winninglayer+1});
    FlexNetwork.W{winninglayer+1}  = [FlexNetwork.W{winninglayer+1}...
        normrnd(0,sqrt(2/(nNode+1)),[wNext,nCluster])];
    FlexNetwork.vW{winninglayer+1} = [FlexNetwork.vW{winninglayer+1}...
        zeros(wNext,nCluster)];
    FlexNetwork.dW{winninglayer+1} = [FlexNetwork.dW{winninglayer+1}...
        zeros(wNext,nCluster)];
    FlexNetwork.c{winninglayer+1}  = [FlexNetwork.c{winninglayer+1};...
        normrnd(0,sqrt(2/(nNode+1)),[nCluster,1])];
    
    FlexNetwork.WPre{winninglayer+1} = [FlexNetwork.WPre{winninglayer+1}...
        normrnd(0,sqrt(2/(nNode+1)),[wNext,nCluster])];
    FlexNetwork.deltaW{winninglayer+1} = [FlexNetwork.deltaW{winninglayer+1}...
        zeros(wNext,nCluster)];
    FlexNetwork.deltaLossW{winninglayer+1} = [FlexNetwork.deltaLossW{winninglayer+1}...
        zeros(wNext,nCluster)];
    FlexNetwork.sumDeltaLossW{winninglayer+1} = [FlexNetwork.sumDeltaLossW{winninglayer+1}...
        zeros(wNext,nCluster)];
    FlexNetwork.weightImportanceW{winninglayer+1} = [FlexNetwork.weightImportanceW{winninglayer+1}...
        zeros(wNext,nCluster)];
end

FlexNetwork.size(winninglayer+1) = FlexNetwork.size(winninglayer+1)...
    + nCluster;
% fprintf(' %d new nodes are FORMED around sample %d\n',nCluster, k)
end