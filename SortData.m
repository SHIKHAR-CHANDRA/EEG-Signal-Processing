load data.csv
eeg_signals = reshape((data)',178*23,500)'; %reshaping from [11500 X 179] to [500 X 4094]
time = (1:4094);
eeg_sample = eeg_signals(2:2,:);
plot(time,eeg_sample),title("Sample EEG signal"),
xlabel("Time"),
ylabel("Amplitude (uV)");