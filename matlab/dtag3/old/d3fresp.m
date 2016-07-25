%automated frequency response
%assume 5 sec frequency points
clear all;clc;

%get s0 from cool edit   
s0 = 2.9e6;  
filename = 'fr003.wav';
gain = 'high'
rate = '240'

%low gain or high gain
switch gain   
    case 'high'
        vi = 0.015/sqrt(2); %high gain input volts (rms)
    case 'low'
        vi = 0.07/sqrt(2); %low gain input volts (rms)
end

%Sample rate
switch rate
    case '120'
        f = [100,200,500,700,1000,2000,5000,7000,10e3,20e3,30e3,40e3,50e3,55e3,58e3];
        step = 600000;
    case '240'
        f = [100,200,500,700,1000,2000,5000,7000,10e3,20e3,30e3,40e3,50e3,60e3,70e3,80e3,90e3,100e3];
        step = 1.2e6;
    case '500'
        f = [100,200,500,700,1000,2000,5000,7000,10e3,20e3,30e3,40e3,50e3,60e3,70e3,80e3,90e3,100e3];
        step = 2.5e6;
end


for n = 1:length(f)
    %s0
    [a,fs] = wavread(filename,[s0 s0 + 100000]);
    g = 20*log10(std(a)./vi);
    psd(a(:,1),[],fs);pause;clc
    g1(n) = g(1);g2(n) = g(2);
    s0 = s0 + step;
end
semilogx(f,g1,f,g2);grid;
%legend('1','2');

    