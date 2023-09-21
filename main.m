%%
clc;
clear all;
close all;
%%
% Load the ECG signal
load('ecg.mat');
ecg = ecg;

%Step 1
% Set the sampling frequency and amplification factor
Fs = 500;
amp_factor = 500;

% Plot the original signal
t = (0:length(ecg)-1)/Fs;
figure;
plot(t, ecg/amp_factor);
xlabel('Time [s]');
ylabel('Voltage [V]');
grid on;
xlim([0 2]);

ecg_fft=fft(ecg);
f=linspace(0,Fs,length(ecg_fft));

ecg_fft(abs(f)<0.5)=0;
ecg_filtered=ifft(ecg_fft);

% Plot the filtered signal
hold on 
plot(t, ecg_filtered/amp_factor);
xlabel('Time [s]');
ylabel('Voltage [V]');
title('ECG signal');
legend('original ecg','filtered ecg(0.5Hz)')
grid on;
xlim([0 2]);

%%
%Step 2
% Design a notch filter to remove 50 Hz noise
ecg1=ecg_filtered;
f0 = 50; % frequency of the notch
Q = 10; % quality factor
bw = f0/Q; % bandwidth
[b, a] = iirnotch(f0/(Fs/2), bw/(Fs/2)); % design the filter

% Apply the notch filter to the signal
ecg2 = filter(b, a, ecg_filtered);

% Plot the filtered signal
figure;
plot(t, ecg2/amp_factor,'b');
xlabel('Time [s]');
ylabel('Voltage [V]');
title('ECG signal (filtered to remove 50hz & to improve SNR)');
grid on;
xlim([0 2]);
hold on

%%
%Step 3
% Apply a low-pass filter to reduce noise
Fc = 35 % cutoff frequency for low-pass filter
[b2,a2] = butter(2, Fc/(Fs/2), 'low'); % design the filter
ecg3 = filter(b2, a2, ecg2);

% Plot the filtered signal
%figure;
plot(t, ecg3/amp_factor,'r');
%xlabel('Time [s]');
%ylabel('Voltage [V]');
%title('ECG signal SNR improved(filtered)');
%grid on;
xlim([0 2]);

% s1=snr(ecg2);
% s2=snr(ecg3);
% SNR_improvemnet_dB= s2 - s1
% SNR_improvemnet_ratio=10^(SNR_improvemnet_dB/10)
%%
%step 4 5

% Find heart rate for ecg
fs=500;
hr_ecg = find_hr(ecg, fs);
fprintf('Heart rate (ecg): %.2f bpm\n', hr_ecg);
title('Autocorrelation of unProcessed Signal of ecg');

% Find heart rate for ecg2
hr_ecg2 = find_hr(ecg2, fs);
fprintf('Heart rate (ecg2): %.2f bpm\n', hr_ecg2);
title('Autocorrelation of Processed Signal of ecg2');

% Find heart rate for ecg3
hr_ecg3 = find_hr(ecg3, fs);
fprintf('Heart rate (ecg3): %.2f bpm\n', hr_ecg3);
title('Autocorrelation of Processed Signal of ecg3');

find_QRS(ecg,fs,amp_factor)
title('ECG signal with detected QRS complexes ecg');

find_QRS(ecg2,fs,amp_factor)
title('ECG signal with detected QRS complexes ecg2');

% find_QRS(ecg3,fs,amp_factor)
% title('ECG signal with detected QRS complexes ecg3');

