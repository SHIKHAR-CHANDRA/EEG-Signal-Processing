function y = seizure_detect(x)
load("eeg_signals.mat","eeg_signals");
load("seizure_info.mat","seizure_info");
eeg_signals;
seizure_info;
[a,d] = haart(eeg_signals(x,:),5); %1-D Haar Transform with level = 5; a = approximation coefficient, d = detail coefficients
u1 = repelem(d{1,1},2); % There is decimation in samples after each level, hence repeat the elements by factor of two.
u2 = repelem(d{1,2},4);
u3 = repelem(d{1,3},8);
u4 = repelem(d{1,4},16);
u5 = repelem(d{1,5},32);
umatrix = nan(4096,5);
umatrix(1:length(u1), 1) = u1;
umatrix(1:length(u2), 2) = u2;
umatrix(1:length(u3), 3) = u3;
umatrix(1:length(u4), 4) = u4;
umatrix(1:length(u5), 5) = u5;
adj_umatrix = umatrix';
adj_umatrix = adj_umatrix(:,1:end-2)
det1 = adj_umatrix(1,:);%Getting level 1 detail coefficients in a single vector
det2 = adj_umatrix(2,:);%Getting level 2 detail coefficients in a single vector
det3 = adj_umatrix(3,:);%Getting level 3 detail coefficients in a single vector
det4 = adj_umatrix(4,:);%Getting level 4 detail coefficients in a single vector
det5 = adj_umatrix(5,:);%Getting level 5 detail coefficients in a single vector
[pts_Opt_1,~,~] = wvarchg(det1); %Finding variance changepoints in level 1 coefficients
[pts_Opt_2,~,~] = wvarchg(det2); %Finding variance changepoints in level 2 coefficients
[pts_Opt_3,~,~] = wvarchg(det3); %Finding variance changepoints in level 3 coefficients
[pts_Opt_4,~,~] = wvarchg(det4); %Finding variance changepoints in level 4 coefficients
[pts_Opt_5,~,~] = wvarchg(det5); %Finding variance changepoints in level 5 coefficients
num_els = [numel(pts_Opt_1),numel(pts_Opt_2),numel(pts_Opt_3),numel(pts_Opt_4),numel(pts_Opt_5)];%Number of variance changepoints in each level
max_els = max(num_els);%Maximum number of variance changepoints
pts_Opt_1(1,max_els) = 0; %Array of level 1 changepoints with max number of variance changepoints
pts_Opt_2(1,max_els) = 0; %Array of level 2 changepoints with max number of variance changepoints
pts_Opt_3(1,max_els) = 0; %Array of level 3 changepoints with max number of variance changepoints
pts_Opt_4(1,max_els) = 0; %Array of level 4 changepoints with max number of variance changepoints
pts_Opt_5(1,max_els) = 0; %Array of level 5 changepoints with max number of variance changepoints
changepts = [pts_Opt_1; pts_Opt_2; pts_Opt_3; pts_Opt_4; pts_Opt_5];
changepts_v = sort(nonzeros(changepts));%all non zero variance changepoints are stored 
time = (1:4094);
figure
ylabel("Amplitude(uV)");
subplot(6,1,1)
plot(time,eeg_signals(x,:))
title('EEG Signal')
subplot(6,1,2)
plot(time,adj_umatrix(1,:))
title('Level 1 Details')
subplot(6,1,3)
plot(time,adj_umatrix(2,:))
title('Level 2 Details')
subplot(6,1,4)
plot(time,adj_umatrix(3,:))
title('Level 3 Details')
ylabel("Amplitude(uV)");
subplot(6,1,5)
plot(time,adj_umatrix(4,:))
title('Level 4 Details')
subplot(6,1,6)
plot(time,adj_umatrix(5,:))
title('Level 5 Details')

AX = gca;
AX.XTick = 0:178:4094;
xlabel('Time')
changepts_plot=figure;
subplot(2,1,1)
AX = gca;
AX.XTick = 0:178:4094;
xticklabels({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23})
hold on
plot(time,eeg_signals(x,:))
line([changepts_v changepts_v], ylim,'Color','green')
title("Predicted Seizures")
ylabel("Amplitude(uV)");
subplot(2,1,2)
seizures2 = (find(~seizure_info(x,:)))
seizures2 = seizures2*178;
plot(time,eeg_signals(x,:))
AX = gca;
AX.XTick = 0:178:4094;
xticklabels({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23})
xlabel('Time')
line([seizures2; seizures2], ylim,'Color','red');
title("True Seizures")
ylabel("Amplitude(uV)");
end
