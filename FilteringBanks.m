function [signalOut,initB]=FilteringBanks(signal,bBank,typeOfFilter,gain,initB)
b=sum(gain.*bBank,1);

switch typeOfFilter
    case 'filter'
       [signalOut,initB] = filter(b, 1, signal, initB);
    case 'fftfilt'
       signalOut = fftfilt(b, signal);
    case 'convFilter'
       signalOut = convFilter(b, signal);

end
end


function signalOut=convFilter(b,signal)
signalOut=[];
for i=1:size(signal,2)
    signalOut=[signalOut, conv(b,signal(:,i))];
end
end