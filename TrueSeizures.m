function TrueSeizures(x,y)
seizures = (find(~x)-1)*178;
seizures2 = seizures +178;
time = (1:4094);
figure
AX = gca;
AX.XTick = 0:178:4094;
xticklabels({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23})
xlabel('Time')
hold on
plot(time,y)
line([seizures; seizures], ylim,'Color','red');
line([seizures2; seizures2], ylim,'Color','red');