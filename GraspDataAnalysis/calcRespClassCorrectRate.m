function correct = calcRespClassCorrectRate(resp)
hits=sum(cellfun(@strcmp,resp,repmat({'hit'},size(resp,1),1)));
crs=sum(cellfun(@strcmp,resp,repmat({'cr'},size(resp,1),1)));

correct=(hits+crs)/size(resp,1);