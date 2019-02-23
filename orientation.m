function [thetaCov, thetaMom] = orientation(img_T)


%wspó³rzêdne pikseli obiektu 
I = find(img_T); 
[j,i] = ind2sub(size(img_T), I);

%momenty przez funkcje dzwigni:
moment = @(p,q) sum((i.^p).*(j.^q).*double(img_T(I)));

% tworzê obiekt typu srtuct
E = struct(); 

% liczê momenty 
E.m00 = moment(0, 0);
E.m10 = moment(1, 0);
E.m01 = moment(0, 1);
E.m11 = moment(1, 1);
E.m02 = moment(0, 2);
E.m20 = moment(2, 0);

% wspolrzedne centrum 
E.x = E.m10/E.m00;
E.y = E.m01/E.m00;

% Licze momenty centralne w obu metodach s¹ zdefiniowane tak samo wed³ug
% dokumentu
a = E.m20/E.m00 - E.x^2;
b =(E.m11/E.m00 - E.x*E.y);
c = E.m02/E.m00 - E.y^2;

% K¹t obrotu  liczony metod¹ momentów 
thetaCov = 1/2*atand(2*b/(a-c)) + (a<c)*180/2; %w razie przekroczenia æwiartki 

v1 = 2*b;
v2 = (c - a + sqrt((c - a)^2 + 4*b^2));
M = sqrt(2*(sqrt((c - a)^2 + 4*b^2) + (c - a))*sqrt((c-a)^2 + 4*b^2));

sin_alfa = v2/M;
cos_alfa = v1/M;

% %sprawdzamy jedynkê trygonometryczn¹
% sin_alfa^2 + cos_alfa^2 == 1

%korzystaj¹c z w³asnoœci funkcji trygonometryczncyh mogê przedstawiæ k¹t
%alfa w metodzie 1) jako tangens k¹ta alfa: tan_alfa = sin_alfa/cos_alfa =
%v2/v1

%jeœli wiêksze to przekroczyliœmy æwiartkê
if (a > c)
    tan_alfa = v2/v1; 
else
    tan_alfa = v1/v2; 
end

%K¹t obrotu liczony metod¹ macierzy kowariancji 
if (v2 == 0) && (v1 == 0)
    thetaMom = 0;
else
    thetaMom =  atand(tan_alfa);
end

end 