function [fap, hitp, missp, crp] = calcRespClassPs(resp)

fas=sum(cellfun(@strcmp,resp,repmat({'fa'},size(resp,1),1)));
hits=sum(cellfun(@strcmp,resp,repmat({'hit'},size(resp,1),1)));
misses=sum(cellfun(@strcmp,resp,repmat({'miss'},size(resp,1),1)));
crs=sum(cellfun(@strcmp,resp,repmat({'cr'},size(resp,1),1)));

fap=fas/size(resp,1);
hitp=hits/size(resp,1);
missp=misses/size(resp,1);
crp=crs/size(resp,1);