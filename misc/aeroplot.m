if ~strcmpi(get_param('aerotest','SimulationStatus'), 'paused')
    aerotest([], [], [], 'compile');
%     aerotest([], [], [], 'term');
end

figureTag = 'Aero';
if isempty(findobj('Tag', figureTag))
    figureHandle = figure;
    figureHandle.Tag = figureTag;
    coeffList = {'ct', 'cc', 'cn', 'cr', 'cp', 'cy', 'cl', 'cd'};
    for iter = 1:numel(coeffList)
        subplot(2, 4, iter);
        hold on;
        grid on; grid minor;
        box on;
        title(coeffList{iter});
    end
    plotbrowser('on');
end

aoaArray            = -30:5:90;
aosArray            = -20:5:20;

mach            = 0.20;
leftInElevon    = 10;
rightInElevon   = 0;
leftOutElevon   = 0;
rightOutElevon  = 0;
leftCanard      = 0;
rightCanard     = 0;
rudder          = 0;
leadingEdgeFlap = 0;
dlg             = 0;

simData.ct  = zeros(numel(aoaArray), numel(aosArray), numel(mach));  
simData.cc  = zeros(numel(aoaArray), numel(aosArray), numel(mach));  
simData.cn  = zeros(numel(aoaArray), numel(aosArray), numel(mach));  
simData.cr  = zeros(numel(aoaArray), numel(aosArray), numel(mach));  
simData.cp  = zeros(numel(aoaArray), numel(aosArray), numel(mach));  
simData.cy  = zeros(numel(aoaArray), numel(aosArray), numel(mach)); 
simData.cl  = zeros(numel(aoaArray), numel(aosArray), numel(mach)); 
simData.cd  = zeros(numel(aoaArray), numel(aosArray), numel(mach)); 

h_geo               = 1000;

cai     = 0.3;
look    = 1;
alphad  = 0;
betad   = 0;
pc      = 0;
rc      = 0;
qc      = 0;
Nz      = 1;
qd      = 0;


dei             = (leftInElevon + rightInElevon) / 2;
dai             = (leftInElevon - rightInElevon) / 2;
dey             = (leftOutElevon + rightOutElevon) / 2;
day             = (leftOutElevon - rightOutElevon) / 2;
de              = (dei + dey) / 2;
da              = (dai + day) / 2;
dne	            = (leftCanard + rightCanard) / 2;
dna	            = (leftCanard - rightCanard) / 2;
dn	            =  dne;
dle	            =  0;
dr	            =  0;

ldg	            =  dlg;

adai            = abs(dai);
adr	            = abs(dr);
aday            = abs(day);
sidai           = sign(dai);
siday           = sign(day);
    

for iAOA = 1:numel(aoaArray)
    Alpha   = aoaArray(iAOA);
    aalpha  = abs(Alpha);
    for iAOS = 1:numel(aosArray)
        Beta    = aosArray(iAOS);
        abeta   = abs(Beta);
        sibeta  = sign(Beta);

        for iMach = 1:numel(mach)
            Mach    = mach(iMach);

            tflow   = (0.5 - Mach) * 10.0;
            tfhigh  = (Mach - 0.4) * 10.0;

            ut      = zeros(26, 1);
            ut(1)   = Alpha;
            ut(2)   = Beta;
            ut(3)   = Mach;
            ut(4)   = h_geo;
            ut(5)   = da;
            ut(6)   = de;
            ut(7)   = dei;
            ut(8)   = dai;
            ut(9)   = dey;
            ut(10)  = day;
            ut(11)  = dne;
            ut(12)  = dn;
            ut(13)  = dna;
            ut(14)  = dr;
            ut(15)  = dle;
            ut(16)  = ldg;
            ut(17)  = cai;
            ut(18)  = tflow;
            ut(19)  = tfhigh;
            ut(20)  = alphad;
            ut(21)  = betad;
            ut(22)  = pc;
            ut(23)  = qc;
            ut(24)  = rc;
            ut(25)  = Nz;
            ut(26)  = qd;
            
            out = aerotest([], [], ut, 'outputs');

            simData.ct(iAOA, iAOS, iMach) = out(1);
            simData.cc(iAOA, iAOS, iMach) = out(2);
            simData.cn(iAOA, iAOS, iMach) = out(3);
            simData.cr(iAOA, iAOS, iMach) = out(4);
            simData.cp(iAOA, iAOS, iMach) = out(5);
            simData.cm(iAOA, iAOS, iMach) = out(6);
            simData.cl(iAOA, iAOS, iMach) = out(7);
            simData.cd(iAOA, iAOS, iMach) = out(8);
        end
    end
end

pastel_colors = [
    0.984, 0.705, 0.682;  % Pastel Red
    0.702, 0.871, 0.984;  % Pastel Blue
    0.702, 0.984, 0.745;  % Pastel Green
    0.984, 0.984, 0.702;  % Pastel Yellow
    0.871, 0.702, 0.984;  % Pastel Purple
    0.984, 0.843, 0.702;  % Pastel Orange
    0.843, 0.984, 0.984;  % Pastel Cyan
    0.984, 0.702, 0.871;  % Pastel Pink
    0.796, 0.878, 0.706;  % Pastel Mint
    0.702, 0.796, 0.984;  % Soft Blue
    0.980, 0.769, 0.894;  % Light Rose
    0.753, 0.690, 0.984;  % Soft Violet
    0.902, 0.902, 0.702;  % Pale Yellow
    0.902, 0.800, 0.694;  % Soft Tan
    0.898, 0.949, 0.741;  % Soft Lime
    0.902, 0.741, 0.851;  % Orchid Pink
    0.753, 0.863, 0.898;  % Icy Blue
    0.914, 0.784, 0.702;  % Peach
    0.757, 0.847, 0.847;  % Light Teal
    0.886, 0.769, 0.918;  % Lavender
];


for iter = 1:numel(coeffList)
    subplot(2, 4, iter);
    [aosGrid, aoaGrid] = meshgrid(aosArray, aoaArray);
    surf(aoaGrid, aosGrid,  simData.(coeffList{iter})(:, :, 1), 'LineStyle', '-', 'LineWidth', 1.0, ...
        'FaceColor', pastel_colors(iter, :) * 0.7, 'EdgeColor', pastel_colors(iter, :) * 0.2);
    view(25, 25);
    title(coeffList{iter});
end

