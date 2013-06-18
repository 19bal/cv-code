%% documentation 
%
%
function data = extract_features(bw,dbg)

n = 4; m = 2;           % Moment iterasyonu ve sýrasý
p = logical(not(bw));
N = size(p,1);
[ZOH AOH PhiOH] = Zernikmoment(p,n,m);              % Zernikemoment fonksiyonu
xlabel({['A = ' num2str(AOH)]; ['\phi = ' num2str(PhiOH)]}); % A=moment genliði, phi=faz acisi(derece olarak)
data=({['A = ' num2str(AOH)]; ['phi = ' num2str(PhiOH)]});
end
%% helpers funcs
%
function [Z A Phi] = Zernikmoment(p,n,m)
N = size(p,1);
x = 1:N; y = x;
[X,Y] = meshgrid(x,y);
R = sqrt((2.*X-N-1).^2+(2.*Y-N-1).^2)/N;
Theta = atan2((N-1-2.*Y+2),(2.*X-N+1-2));
R = (R<=1).*R;
Rad = radialpoly(R,n,m);    % get the radial polynomial

Product = p(x,y).*Rad.*exp(-1i*m*Theta);
Z = sum(Product(:));        % calculate the moments

cnt = nnz(R)+1;             % count the number of pixels inside the unit circle
Z = (n+1)*Z/cnt;            % normalize the amplitude of moments
A = abs(Z);                 % calculate the amplitude of the moment
Phi = angle(Z)*180/pi;      % calculate the phase of the mement (in degrees)
end

function rad = radialpoly(r,n,m)
rad = zeros(size(r));                     % Initilization
for s = 0:(n-abs(m))/2
  c = (-1)^s*factorial(n-s)/(factorial(s)*factorial((n+abs(m))/2-s)*factorial((n-abs(m))/2-s));
  rad = rad + c*r.^(n-2*s);
end
end
%
