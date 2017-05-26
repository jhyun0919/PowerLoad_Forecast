%load 'input_data/ACTEWAGL/helm_input_wd.mat'; Result_File='optimal_data/ACTEWAGL/layer1/helm_optimal_wd.csv';
%load 'input_data/ACTEWAGL/helm_input_lwd.mat'; Result_File='optimal_data/ACTEWAGL/layer1/helm_optimal_lwd.csv';
%load 'input_data/ACTEWAGL/helm_input_lww.mat'; Result_File='optimal_data/ACTEWAGL/layer1/helm_optimal_lww.csv';
load 'input_data/ACTEWAGL/helm_input_lwdw.mat'; Result_File='optimal_data/ACTEWAGL/layer1/helm_optimal_lwdw.csv';

NumberofHiddenNeurons=1;
ActivationFunction='sig';

for x = 1:300
    RMSE_temp = [];
    for xx = 1:20
    	x
    	N1=NumberofHiddenNeurons;
		N=N1+1;
    	b1=2*rand(size(train_x',2)+1,N1)-1;
		b=orth(2*rand(N1+1,N)'-1)';
		C = 2^-30; s = .8;

        [TrainingAccuracy_RMSE,TestingAccuracy_RMSE,Training_time,Testing_time] = helm_regression_01(train_x, train_y, test_x, test_y, b1, b, s, C);
        RMSE_temp(xx,:) = TestingAccuracy_RMSE;
    end
    
    RMSE_List(x,:) = mean(RMSE_temp);
    NumberofHiddenNeurons = NumberofHiddenNeurons + 1;
    
end

AccList = horzcat(RMSE_List);
headers = {'RMSE'};
csvwrite_with_headers(Result_File,AccList,headers)