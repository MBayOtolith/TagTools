%calibration for Dtag3-04
CAL.TAG = 305 ;

CAL.TREF = 20 ;                     % temperature of calibration
%##########DANGER!  these tcal values are from tag2!!!!!
CAL.TCAL = [125 75] ;               % temperature sensor calibration

CAL.PCAL = [2531 -67.01];       %pressure (to m)

CAL.PTC = 0 ;
CAL.Pi0 = [] ;                        % pressure bridge current
CAL.Pr0 = [] ;                             % current sensing resistor

CAL.ACAL = [5.04, -2.48          %accelerometer
    4.92,-2.4
    5.06,-2.59];

CAL.MCAL = [] ;

CAL.APC = [];  % pressure sensitivity on ax,ay,az
CAL.ATC = [] ;                    % temperature sensitivity on ax,ay,az
CAL.AXC = [] ;                    % cross-axis sensitivity on A

CAL.MMBC = [];          % mbridge sensitivity on mx,my,mz
CAL.MPC = [] ;                    % pressure sensitivity on mx,my,mz
CAL.MXC =[] ;           % cross-axis sensitivity on M

CAL.VB = [];           % battery voltage conversion to volts
CAL.PB = [] ;       % pb conversion to volts
CAL.PBTREF = [] ;        % pb value in volts at TREF
CAL.MB = [];       % mb conversion to volts
CAL.MBTREF = [] ;        % mb value in volts at TREF


%run accelerometer calibration
ax = polyval(CAL.ACAL(1,:),s(:,1));
ay = polyval(CAL.ACAL(2,:),s(:,2));
az = polyval(CAL.ACAL(3,:),s(:,3));
A = [ax, ay, az];

% %run magnetometer calibration
%need constants!!
% mx = polyval(CAL.MCAL(1,:),s(:,4));
% my = polyval(CAL.MCAL(2,:),s(:,5));
% mz = polyval(CAL.MCAL(3,:),s(:,6));
% M = [mx, my, mz];

%run pressure calibration (conversion to meters)
%note: this is also done separately if you run d3calpressure
p = polyval(CAL.PCAL,s(:,7));

%temperature (NEED CALIBRATION CONSTANTS!)
%note: this is also done separately if you run d3calpressure
tempr = polyval(CAL.TCAL,s(:,8)) ;



