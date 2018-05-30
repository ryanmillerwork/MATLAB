function dp=calcdprimes(resp)

hit=sum(cellfun(@strcmp,resp,repmat({'hit'},size(resp,1),1)));
miss=sum(cellfun(@strcmp,resp,repmat({'miss'},size(resp,1),1)));
cr=sum(cellfun(@strcmp,resp,repmat({'cr'},size(resp,1),1)));
fa=sum(cellfun(@strcmp,resp,repmat({'fa'},size(resp,1),1)));

pHit=hit/(hit+miss); %proportion of match trials when subject says match
pFA=fa/(fa+cr); %proportion of non-match trials when subject says match
nTarget=hit+miss;
nDistract=cr+fa;

dp=dprime(pHit,pFA,nTarget,nDistract);