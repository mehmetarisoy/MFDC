W = 100000;
S = 1667;
WS = 60;
A = 7;
cBar = 15.40;
rhoE = 0.000889;
Vmph = 500;
Vfps = 733;
mu = 272;
Iy = 7 * mu;
CLe = 0.25;
CWe = CLe;
CDe = 0.0188;
tStar = 0.0105;
CLalpha = 4.88;
Cmalpha = -4.88 * (0.15);
CDalpha = 2 * CLe * CLalpha / (7 * pi);
CLalphaDot = 0;
CmalphaDot = -4.20;
CLq = 0;
Cmq = -22.9;
CTV = -2*CDe;
CLV = 0;
CDV = 0;
CmV = 0;

A = zeros(4, 4);
A(1, 1) = (CTV - CDV) / (2*mu);
A(1, 2) = (CLe - CDalpha) / (2*mu);
A(1, 3) = 0;
A(1, 4) = -CWe/(2*mu);
A(2, 1) = -(CLV + 2*CWe) / (2*mu + CLalphaDot);
A(2, 2) = -(CLalpha + CDe) / (2*mu + CLalphaDot);
A(2, 3) = (2*mu - CLq)/(2*mu + CLalphaDot);
A(2, 4) = 0;
A(3, 1) = (CmV - ( CmalphaDot*(CLV + 2*CWe)/(2*mu + CLalphaDot) ))/Iy;
A(3, 2) = (Cmalpha - (CmalphaDot*(CLalpha+CDe))/(2*mu+CLalphaDot)) / Iy;
A(3, 3) = (Cmq + (CmalphaDot*(2*mu-CLq))/(2*mu + CLalphaDot))/Iy;
A(3, 4) = 0;
A(4, 1) = 0;
A(4, 2) = 0;
A(4, 3) = 1;
A(4, 4) = 0;


[V, D, W] = eig(A);
eigSP1 = D(1, 1);
eigSP2 = D(2, 2);
eigPH1 = D(3, 3);
eigPH2 = D(4, 4);

vsp1 = V(:, 1);
vsp2 = V(:, 2);
vph1 = V(:, 3);
vph2 = V(:, 4);

vesp1 = [0.279e-2 + 0.180e-2*1i;
    0.333+0.195*1i;
    -0.455e-2+0.578e-2*1i;
    0.329+0.382e-1*1i];

vesp2 = [0.279e-2 - 0.180e-2*1i;
    0.333-0.195*1i;
    -0.455e-2-0.578e-2*1i;
    0.329-0.382e-1*1i];

veph1 = [-0.227e-1 + 0.281*1i;
    0.639e-3 - 0.629e-2*1i;
    -0.115e-4 + 0.202e-3*1i;
    0.353 + 0.116e-2*1i];

veph2 = [-0.227e-1 - 0.281*1i;
    0.639e-3 + 0.629e-2*1i;
    -0.115e-4 - 0.202e-3*1i;
    0.353 - 0.116e-2*1i];


figure;
subplot(2, 2, 1);
bar([real(vsp1), real(vsp2), real(vesp1), real(vesp2)]);
subplot(2, 2, 2);
bar([real(vph1), real(vph2), real(veph1), real(veph2)]);

subplot(2, 2, 3);
bar([imag(vsp1), imag(vsp2), imag(vesp1), imag(vesp2)]);
subplot(2, 2, 4);
bar([imag(vph1), imag(vph2), imag(veph1), imag(veph2)]);