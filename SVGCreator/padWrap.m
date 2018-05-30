function out = padWrap(in, top)
%works on integers between -inf and 23
in=in(:);
out=nan(size(in));
for i=1:size(in,1)
    if in(i) < 1
        out(i)=mod(in(i)-1,top)+1;
    elseif in(i) > top
        out(i)=mod(in(i),top);
    else
        out(i)=in(i);
    end    
end