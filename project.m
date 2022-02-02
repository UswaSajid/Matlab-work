%generate the noisy signal which will be filtered
x= cos(2*pi*12*[0:0.001:1.23]);
x(end) = [];
[b a] = butter(2,[0.6 0.7],'bandpass');
filtered_noise = filter(b,a,randn(1, length(x)*2));
x = (x + 0.5*filtered_noise(500:500+length(x)-1))/length(x)*2;
plot(x)
title('Noisy signal')
xlabel('Samples');
ylabel('Amplitude')
 
%plot magnitude spectrum of the signal
X_mags = abs(fft(x));
figure(10)
plot(X_mags)
xlabel('DFT Bins')
ylabel('Magnitude')
 
%plot first half of DFT (normalised frequency)
num_bins = length(X_mags);
plot([0:1/(num_bins/2 -1):1], X_mags(1:num_bins/2))
xlabel('Normalised frequency (\pi rads/sample)')
ylabel('Magnitude')
 
%design a second order filter using a butterworth design technique 
[b a] = butter(2, 0.3, 'low')
 
%plot the frequency response (normalised frequency)
H = freqz(b,a, floor(num_bins/2));
hold on
plot([0:1/(num_bins/2 -1):1], abs(H),'r');
 
%filter the signal using the b and a coefficients obtained from
%the butter filter design function
x_filtered = filter(b,a,x);
 
%plot the filtered signal
figure(2)
plot(x_filtered,'r')
title('Filtered Signal - Using Second Order Butterworth')
xlabel('Samples');
ylabel('Amplitude')
 
%Redesign the filter using a higher order filter
[b2 a2] = butter(20, 0.3, 'low')
 
%Plot the magnitude spectrum and compare with lower order filter
H2 = freqz(b2,a2, floor(num_bins/2));
figure(10)
hold on
plot([0:1/(num_bins/2 -1):1], abs(H2),'g');
 
%filter the noisy signal and plot the result
x_filtered2 = filter(b2,a2,x);
figure(3)
plot(x_filtered2,'g')
title('Filtered Signal - Using 20th Order Butterworth')
xlabel('Samples');
ylabel('Amplitude')
 

