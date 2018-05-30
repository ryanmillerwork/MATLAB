function master=combineDG(files)

%This is meant to combine and clean up dg files to be in a common format and output a single data2 structure

% clear
current = pwd;
basePath = 'C:/Users/Ryan/Documents/Matlab/MatlabData/PlanetEarthBlocks';
cd(basePath);
% files= dir('*.dgz');
cd(current);

for i=1:size(files,1)
    %Read in file to get data2
    fname=files{i};
    data = dg_read(fullfile(basePath, fname));
    data2 = rmfield(data,{'load_params' 'filename' 'version' 'ems_source' 'ems_kern' 'subj'});

    %Check if this has a stim_grayscale field and set it to zeros if not
    if ~isfield(data2,'stim_grayscale')
        data2.stim_grayscale=zeros(size(data2.TDT_spike_times));
    end
    
    %If this is the first go through, we're done. Otherwise we need to concatanate data2 to master
    if ~exist('master','var')
        master=data2;
    else
        fields = fieldnames(master);
        
        for ii=1:size(fields,1) %Step through each field of master, grab the master and new, concatenate
            m=eval(['master.' fields{ii}]); %Grab master of this field
            new=eval(['data2.' fields{ii}]); %Grab master of this field
            
            if strcmp(fields{ii},'stim_description')
                m(:,size(m,2)+1:100)=' ';
                new(:,size(new,2)+1:100)=' ';
            end
            
            update=[m; new];
            
            eval(['master.' fields{ii} '=update;']);
            
        end
    end
    
%     size(master.file)
end