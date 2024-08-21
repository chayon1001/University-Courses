clear; clc;
img=imread('img/saad.png');
imgGRAY=rgb2gray(img);
band=[];
for i=0:255
   band=[band i];
 end
freq=[];
count=0;
for i=0:255
     for j=1:424410
         if i==imgGRAY(j)
             count = count + 1;
         end
     end
     freq=[freq count];
     count=0;
end
% Cumulative sum:
sum=0;
cum=[];
for i=1:256
   sum=sum+freq(i);
   cum=[cum sum];
end
% PDF probability density function:
ans=0;
PDF=[];
for i=1:256
   ans=cum(i)/cum(end);
   PDF=[PDF ans];
   ans=0;
end
% PDF * Max gray value:
ans=0;
maxPDF=[];
for i=1:256
   ans=PDF(i)*band(end);
   maxPDF=[maxPDF ans];
   ans=0;
end
% ROUND(PDF * Max gray value):
ans=0;
roundMaxPDF=[];
for i=1:256
   roundMaxPDF=[roundMaxPDF round(maxPDF(i))];
   ans=0;
end

figure();
stem(band,freq);
title("Default");

% Equilized histogram:
eqHgram=[];
temp=0;
sum =0;
for i=1:256
    temp=i-1;
    index = find(roundMaxPDF==temp);
    index;
    lenIndex = length(index);
    lenIndex;
    if lenIndex == 0
        eqHgram=[eqHgram 0];
    else
        for i=1:lenIndex
            sum = sum + freq(index(i));
        end
        eqHgram=[eqHgram sum];
        sum = 0;
    end
end

figure();
stem(band,eqHgram);
title("Equilized");

result=[band;freq;cum;PDF;maxPDF;roundMaxPDF;eqHgram];
result