function find_QRS(ecg,Fs,amp_factor)
% Apply the Pan-Tompkins algorithm to detect the QRS complex
% (code from previous answer)
Fc = 5; % cutoff frequency for high-pass filter
[b3,a3] = butter(2, Fc/(Fs/2), 'high'); % design the filter
ecg_filtered2 = filter(b3, a3, ecg);
ecg_diff = diff(ecg_filtered2);
ecg_sq = ecg_diff.^2;
N = round(0.15*Fs);
h = ones(1, N)/N;
ecg_int = conv(ecg_sq, h, 'same');
mean_rr = mean(diff(find(ecg_int > max(ecg_int)*0.6)));
threshold = 0.3*max(ecg_int)*mean_rr;
qrs_i_raw = [];
qrs_amp_raw = [];
last_qrs_i = 0;
for i = 1:length(ecg_int)
    if ecg_int(i) > threshold && i > last_qrs_i + round(0.35*Fs)
        [qrs_amp_raw(end+1), qrs_i_raw(end+1)] = max(ecg_filtered2(i-round(0.15*Fs):i));
        qrs_i_raw(end) = qrs_i_raw(end) + i-round(0.15*Fs)-1;
        last_qrs_i = qrs_i_raw(end);
    end
end

% Plot the results
t_raw = (0:length(ecg)-1)/Fs;
figure;
plot(t_raw, ecg/amp_factor);
hold on;
plot(qrs_i_raw/Fs, qrs_amp_raw/amp_factor, 'rv');
xlabel('Time [s]');
ylabel('Voltage [V]');
grid on;
xlim([0 2]);

end