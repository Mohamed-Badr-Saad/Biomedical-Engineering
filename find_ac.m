function find_ac(ecg,fs)

% Step 4: Finding the heart rate using autocorrelation
% Calculate autocorrelation
R = xcorr(ecg);
tau = linspace(-length(ecg)+1, length(ecg)-1, length(R));
plot(tau, R);
xlabel('\tau');
ylabel('Autocorrelation');

end