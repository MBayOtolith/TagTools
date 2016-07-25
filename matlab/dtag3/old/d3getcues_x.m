function    [ct,ref_time,fs,fn,recdir] = d3getcues_x(recdir,prefix,suffix)
%
%    [ct,ref_time,fs,fn,recdir] = d3getcues(recdir,prefix,suffix)
%

ct = [] ; fs = [] ; fn = [] ;

if nargin<2,
   help d3getcues
   return
end

if nargin<3 | isempty(suffix),
   suffix = 'wav' ;
end

if ~isempty(recdir) & ~ismember(recdir(end),'/\'),
   recdir(end+1) = '\' ;
end

recdir(recdir=='/') = '\' ;

cuefname = [recdir prefix suffix 'cues.mat'] ;
%note: it doesn't take much time to make this file, and saving/loading it
%has caused a lot of errors...one solution is this - to just make it anew
%each time it is needed, from the original wavt and wavxt files.
%if ~exist(cuefname,'file')
   cuefname = makecuefile_x(recdir,prefix,suffix) ; %this version of makecuefile takes into account cases with overflow "wavx" files IF there is also a corresponding wavxt file.
%end

if isempty(cuefname),
   fprintf(' Unable to make cue file\n') ;
   return
end

C = load(cuefname) ;
fs = C.fs ;
ct = C.cuetab ;
fn = C.fn ;
fn = strcat((char(repmat(recdir,length(fn),1))),fn')'; %edit sdr 12/11 to work with tag3audit...
ref_time = C.ref_time ;
return
