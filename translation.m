function [imgTrans] = translation(img) 

imgD = im2double(img); 

%rozmiar 
[x,y] = size(imgD);

%licz� moment zerowy, czyli ilo�c pikseli w sylwetrce
m00 = sum(sum(imgD));

%licz� momenty pierwszego rz�dzi m10 i m01 
m10 = 0;
m01 = 0;

for i = 1:x
    for j = 1:y 
        
    m10 = imgD(i,j)*i + m10; 
    m01 = imgD(i,j)*j + m01; 
    
    end
end

%�rodek masy obrazu ic oraz jc

ic = ceil(m10/m00);
jc = ceil(m01/m00); 

figure;
imshow(imgD); 
hold on; 
plot(jc, ic,'rx');
title('�rodek ci�ko�ci obiektu');

%przenosze srodek obiektu do srodka ukladu wspolrzednych
imgTrans = imtranslate(imgD,[ceil(y/2)-jc,ceil(x/2)-ic]);

end 