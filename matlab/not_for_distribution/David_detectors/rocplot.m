function pts = rocplot(data, sampling_rate, FUN, bktime, indices, events, ntests, testint) 
  
tpevents = ((indices/sampling_rate)/bktime);
sr = sampling_rate;

for k = 1:ntests
    if k == 1
        thresh = testint;
    end
    detections = detect(data, sr, FUN, thresh, bktime, false, sampling_rate);
    detections = detections.peak_time;
    True_Positive_Rate = acc_test(detections, events, sampling_rate, tpevents);
    True_Positive_Rate = True_Positive_Rate.hits_rate;
    False_Positive_Rate = acc_test(detections, events, sampling_rate, tpevents);
    False_Positive_Rate = False_Positive_Rate.false_alarms_rate;
    thresh = thresh + testint;
    if k == 1
        pts = [0,0; True_Positive_Rate, False_Positive_Rate];
    else
        pts = [pts; True_Positive_Rate, False_Positive_Rate];
    end
end
pts = [pts; 1,1];
pts = sortrows(pts);
scatter(pts(:,1), pts(:,2))
hold on
plot(polyval(polyfit(pts(:,1), pts(:,2), 1), pts(:,1)))
hold off
end