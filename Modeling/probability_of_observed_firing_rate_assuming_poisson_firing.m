%% 
%Dethroning the Fano Factor: a flexible, model-based approach to partitioning neural variability
% https://www.biorxiv.org/content/biorxiv/early/2017/07/19/165670.full.pdf
% Jonathan Pillow


%% equation 
% p(r|x) = (1/r!)(lambx^r)(e^-lambx)
% assumes mean == variance. in many brain areas you have over-dispersion (i.e., variance > mean)


lambx = 30; % actual stimulus specific firing rate in units spikes/bin
r = 10;     % observed spikes/bin

figure; hold on;
for r=0:100
    p=(1/factorial(r))*(lambx^r)*exp(-lambx);
    
    plot(r,p,'.')
    
    
end
