function y = HaarTransform(x)
if ~isvector(x)
    error('Input must be a vector')
end
[a,d] = haart(x,5); %function for Haar Transform with level = 5
u1 = repelem(d{1,1},2);
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
adj_umatrix = adj_umatrix(:,1:end-2);
y = adj_umatrix;
