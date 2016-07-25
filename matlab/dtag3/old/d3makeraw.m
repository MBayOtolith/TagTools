function [s, fs] = d3makeraw(tag, savefile, chips);
%read dtag 3 swv and xml files to produce RAW files.
%inputs:
% tag      is the tag id string, such as 'tt11_123a' 
% savefile is 1 if you want to save the resulting raw file, 0 if not.
%          default is to save the file.
% chips    is a vector of chip numbers to read (if omitted, default is to
%          read all chips).
%
 %
%Stacy DeRuiter & Tom Hurst, WHOI, 2011

if nargin < 1
    help d3makeraw
end

if nargin < 2
    savefile = 1;
end

if nargin < 3
    chips = [];
end

%generate file names, including path to swv directory
if ~isempty(findstr(tag,'.')) & isempty(chips),
   if exist(tag,'file'),
      fnames = {tag} ;           % complete filename was given
   else
      fprintf('Cannot open file %s - check path and name\n',tag) ;
      return
   end
else
   [fnames,chips] = d3makefnames(tag, 'SWV', chips) ;
end

if length(fnames)==0,
   fprintf('No swv files found - check tag id and AUDIO path\n') ;
   return
end

if length(tag) > 6
    stag = [tag(1:2) tag(6:9)]; %short tag id string, without 'yy_' in the middle
end

%clear memory of old versions of needed variables
mx = []; %magnetometer x
my = []; %magnetometer y
mz = []; %magnetometer z
ax = []; %accelerometer x
ay = []; %accelerometer y
az = []; %accelerometer z
press = []; %pressure
temp = []; %temperature
pbridge = []; %pressure bridge
mbridge = []; %magnetometer bridge
Vb = []; %battery voltage
xx = [];
fs_interp = [];
xinterp = [];
X = [];

%vector of sampling rates that are multiples of 5
testfs = [5:5:2000];

%determine sampling rate conversions
[x,fs,uchans] = d3parseswv(fnames{1}(1:end-4)); %get data, sampling rates and channel id info from xml file
for ii = 1:length(fs)
    fsi = testfs(testfs >= fs(ii)); 
    fs_interp(ii) = fsi(1); %smallest multiple of 5 greater than the sensor sampling rate
end

%read xml and swv files into matlab 
lag = 0; %initialize
for k = 1:length(chips) %loop over all swv files
    disp(['processing file number ' num2str(k) ' of ' num2str(length(chips))]);
    clear x xinterp xi
    xx = [];
    [x,fs,uchans] = d3parseswv(fnames{k}(1:end-4)); %get data, sampling rates and channel id info from xml file
    for ii = 1:length(fs) %loop over all channels
        if rem(fs(ii), 5) ~= 0 %if sampling rate is not a multiple of 5
            w = (1:length(x{ii}))./fs(ii); %original sample times
            wi = (1/fs_interp(ii))-lag:(1/fs_interp(ii)):w(end); %sample times with fs that the next greater mult of 5
            x{ii} = interp1( w, x{ii}, wi , 'pchip'); %interpolate sensor data to a sampling rate that is a mult of 5
            lag = w(end)-wi(end); %time from last interpolated sample until last original sample
        end
        xi = decdc(x{ii}(:) , fs_interp(ii)/5 );
        xx(1:length(xi),ii) = xi;
    end
  X = [X; xx];
end
d2tod3 = [7 8 9 2 1 3 10 11 20 19 14 12];
s = X(:,d2tod3);
s(:,9) = 0*s(:,9);
fs = 5;
if savefile
    saveraw(tag, s, fs); %saveraw function from tag 2 tools - must have tag path set for this to work
end
function    saveraw(tag,s,fs)
%
%    saveraw(tag,s,fs)
%    Saves the raw sensor data to a correctly-named file in the
%     raw directory on the tag path.
%
%    mark johnson
%    majohnson@whoi.edu
%    last modified: 24 June 2006

if nargin<1,
   help saveraw
   return
end

% try to make filename
fname = makefname(tag,'RAW') ;
if isempty(fname),
   return
end

% save the variables to the file
save(fname,'s','fs') ;

