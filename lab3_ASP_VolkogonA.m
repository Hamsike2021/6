%% Filters design
% FIR-finite impulse response — конечная импульсная характеристика
freqArray = [31, 62, 125, 250, 500, 1000, 2000, 4000,8000,16000];
order = 1024; 
fs = 44100;


bBank=CreateFilters(freqArray,order,fs);



%% Filtering of signals
[signal,fs] = audioread('song.mp3');
gain=ones(length(freqArray),1);
initB=zeros(1,order);
tic
signalOut_1=FilteringBanks(signal,bBank,'filter',gain,initB);
toc
tic
signalOut_2=FilteringBanks(signal,bBank,'fftfilt',gain,initB);
toc
tic
signalOut_conv=FilteringBanks(signal,bBank,'convFilter',gain,initB);
toc

%% Stream sound
deviceWriter = audioDeviceWriter('SampleRate', fs);
fileReader = dsp.AudioFileReader('song.mp3');
gain = [10 10 10 0.1*ones(1, 7)]';
gain=ones(10,1);
while  ~isDone(fileReader)
    gain = rand(size(freqArray))';
    audioData = fileReader();
    [dataPortionFiltering,initB]=FilteringBanks(audioData,bBank,'filter',gain,initB);
    deviceWriter(dataPortionFiltering)
end