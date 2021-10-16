load data1.csv
seizure_info = reshape(data1',23,500)';
seizure_info = seizure_info ~= 1; % storing seizure seconds in a new variable
