# Biomedical Engineering Final Project

## Overview
This GitHub repository contains the code and resources for my final project in Biomedical Engineering, completed during my studies at the Faculty of Engineering, Alexandria University. The project focuses on signal processing and analysis of ECG (Electrocardiogram) data using MATLAB.

## Project Details
### 1. Removing Signals from Muscle Movement
- The project begins by downloading an ECG signal from the web, sampled at 500 Hz.
- The goal is to remove low-frequency muscle movement signals that often overlap the ECG signal.
- This is achieved by Fourier transforming the signal, setting frequencies below 0.5 Hz to zero, and performing an inverse Fourier transform.
- The resulting filtered signal is named `ecg1`.

### 2. Removing 50 Hz Interference
- ECG signals are often contaminated with 50 Hz noise from power outlets.
- A Notch filter with a zero at 50 Hz is designed and applied to remove this interference.
- The filtered signal is named `ecg2`.

### 3. Increasing Signal-to-Noise Ratio
- The project explores the trade-off between bandwidth and noise in the ECG signal.
- Different cutoff frequencies are tested to find a compromise between preserving the ECG shape and reducing noise.
- The filtered signal with the optimal cutoff frequency is named `ecg3`.

### 4. Finding the Heart Rate Using Autocorrelation
- The heart rate is determined using the autocorrelation function of the signal.
- An automated procedure is implemented to find the first local maximum after the global maximum at tau = 0 in the autocorrelation function.
- The program can be applied to both the processed `ecg3` or `ecg2` signal and the unprocessed `ecg` signal.
- Plots of the autocorrelation functions are included for documentation.

### 5. Finding the QRS Complex
- The QRS complex in an ECG signal is detected using the Pan-Tompkins algorithm.
- The algorithm applies a series of filters to highlight the rapid heart depolarization and remove background noise.
- The signal is squared to amplify the QRS contribution, simplifying QRS complex identification.
- An automated procedure for QRS detection is provided for both the processed `ecg3` or `ecg2` signal and the unprocessed `ecg` signal.

## Usage
Feel free to explore the code and resources in this repository for signal processing and analysis of ECG data. You can use, modify, and extend the code for your own projects or research in the field of Biomedical Engineering.

## Contributing
Contributions and improvements to the project are welcome! If you have suggestions, bug fixes, or want to collaborate, please create a pull request or open an issue.

## Contact
If you have any questions or would like to connect, you can reach me at [badrm7103@gmail.com].

