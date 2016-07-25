function    cuefname = makecuefile_x(recdir,prefix,suffix)
%
%    cuefname = makecuefile(recdir,prefix,suffix)
%

if nargin<3 | isempty(suffix),
   suffix = 'wav' ;
end

cuefname = [recdir  prefix suffix 'cues.mat'] ;

% check for t-type timing files
[cuetab,fn,id] = d3makettab_x(recdir,prefix,suffix) ;
% fname = [recdir fn{cuetab(1,1)} ] ;

if isempty(cuetab),
   [cuetab,fn,id] = d3makectab(recdir,prefix,suffix) ; %can't figure out how to make this work for cases with overflow wavx files but no wavxt files...I think it may be a non-existent case (d3read that makes wavx also makes wavxt) so not worrying about it for now... SDR 2012 Jan.
%     fname = [fn{cuetab(1,1)} '.' suffix ] ;
end
fname = [recdir fn{1} '.' suffix] ;

if ~exist(fname,'file'),
   fprintf(' No wav file found matching first file name\n') ;
   return
end
[s,fs] = wavread16(fname,'size') ;
fs = fs(1) ;

% nominate a reference time and refer the cues to this time
ref_time = cuetab(1,2) ;
ctimes = (cuetab(:,2)-ref_time)+cuetab(:,3)*1e-6 ;
cuetab = [cuetab(:,1) ctimes cuetab(:,4)] ;

vv = version ;
if vv(1)>'6',
   save(cuefname,'-v6','ref_time','fn','fs','id','cuetab') ;
else
   save(cuefname,'ref_time','fn','fs','id','cuetab') ;
end

return
