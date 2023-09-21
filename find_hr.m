function hr = find_hr(ecg, fs)
% Compute autocorrelation function
[Rxx, lags] = xcorr(ecg, 'coeff');
x = ecg;
% Find global maximum at tau=0
global_max = max(Rxx);
global_max_index = find(Rxx == global_max);

% Limit search interval for local maximum
min_hr = 40; % beats per minute
max_hr = 200; % beats per minute
min_lag = round(fs * 60 / max_hr); % in samples
max_lag = round(fs * 60 / min_hr); % in samples
search_interval = global_max_index + min_lag : global_max_index + max_lag;

% Find first local maximum after global maximum in search interval
local_max_index = nan;
for i = search_interval
    if Rxx(i) > Rxx(i-1) && Rxx(i) > Rxx(i+1)
        local_max_index = i;
        break;
    end
end
% Plot results
figure;
subplot(2,1,1);
plot((0:numel(x)-1)./fs, x);
xlabel('Time (s)');
ylabel('ECG signal');
title('ECG signal');

subplot(2,1,2);
hold on;
find_ac(ecg,fs)


% Compute heart rate from local maximum location
hr = 60 / (lags(local_max_index) / fs);


end