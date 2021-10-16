function y = VarianceChangePlot(x)
det1 = x(1,:);
det2 = x(2,:);
det3 = x(3,:);
det4 = x(4,:);
det5 = x(5,:);
[pts_Opt_1,kopt_1,t_est_1] = wvarchg(det1);
[pts_Opt_2,kopt_2,t_est_2] = wvarchg(det2);
[pts_Opt_3,kopt_3,t_est_3] = wvarchg(det3);
[pts_Opt_4,kopt_4,t_est_4] = wvarchg(det4);
[pts_Opt_5,kopt_5,t_est_5] = wvarchg(det5);
num_els = [numel(pts_Opt_1),numel(pts_Opt_2),numel(pts_Opt_3),numel(pts_Opt_4),numel(pts_Opt_5)];
max_els = max(num_els);
pts_Opt_1(1,max_els) = 0;
pts_Opt_2(1,max_els) = 0;
pts_Opt_3(1,max_els) = 0;
pts_Opt_4(1,max_els) = 0;
pts_Opt_5(1,max_els) = 0;
changepts = [pts_Opt_1; pts_Opt_2; pts_Opt_3; pts_Opt_4; pts_Opt_5];
changepts_v = nonzeros(changepts);
changepts_v = sort(nonzeros(changepts));
changepts_s = changepts_v/178;
time = (1:4094);
figure
subplot(5,1,1)
plot(time,x(1,:))
title('Level 1 Details')
subplot(5,1,2)
plot(time,x(2,:))
title('Level 2 Details')
subplot(5,1,3)
plot(time,x(3,:))
title('Level 3 Details')
subplot(5,1,4)
plot(time,x(4,:))
title('Level 4 Details')
subplot(5,1,5)
plot(time,x(5,:))
title('Level 5 Details')
AX = gca;
AX.XTick = 0:178:4094;
xlabel('Time')
changepts_plot=figure;
AX = gca;
AX.XTick = 0:178:4094;
xlabel('Time')
hold on
plot(time,eeg_signals(1,:))
line([changepts_v changepts_v], ylim)