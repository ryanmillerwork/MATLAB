%data to matlab format
%01.26.2017

basePath = 'C:\Users\Ryan\Documents\Matlab\MatlabData';
fname = 'y_atm_planetEarth_012517.dgz';

data = dg_read(fullfile(basePath, fname));
data2 = rmfield(data,{'load_params' 'filename' 'version' 'ems_source' 'ems_kern' 'subj'});
subjid=str2double(data.subj(1,end));


clear basePath fname