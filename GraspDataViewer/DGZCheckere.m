

clear all
basePath = 'C:\Users\Ryan\Documents\Data\DGZs';
cd(basePath)
files=dir;
list=[];

for file=1:size(files,1)
    filename=files(file).name;
    if filename(end) ~= 'z'
        continue;
    end
    clear d
    data = dg_read(fullfile(basePath, filename));
    
    %ignored columns: load_params, filename, version, status, endtrial, endobs, stimtriggers, onlinesacs, onlineacqs
    % onlineacqs_params, stimevents, stimdata, presrank, ems2, ems_kern,
    %basic info
    d.blocks=data.file;
    % d.subject=data.subj(1,:);
    for i=1:length(d.blocks)
%         d.subject(i,1)=fname(participant,2); %{data.subj(i,:)};
        d.date(i,1)=str2double([num2str(data.month(i,:)) num2str(data.day(i,:)) num2str(data.year(i,:))]);
    end
    
    d.stim=data.stimtype;
    
    d.fixOn=data.fixon;
    d.fixOff=data.fixoff;
    d.stimOn=data.stimon;
    d.stimOff=data.stimoff;
    d.response=data.resp;
    d.responseTime=data.response;
    d.answer=data.side;
    d.reactionTime=data.rts;
    d.target=data.target;
    d.delay=data.delay;
    d.touchMode=data.touch_mode;
    d.trials=data.obsid;
    
    %sample info
    d.sampleMode=data.sample_mode;
    d.sampleID=data.sample_id;
    d.sampleSide=data.sample_side;
    d.sampleAvailOn=data.sample_availOn;
    d.sampleAvailOff=data.sample_availOff;
    d.samplePosition=data.sample_position;
    d.sampleScale=data.sample_scale;
    d.sampleRotation=data.sample_rotation;
    d.sampleCoords=data.grasp_coords_sample;
    
    %choice 1 (left touch) info
    d.choice1Mode=data.choice1_mode;
    d.choice1ID=data.choice1_id;
    d.choice1Port=data.choice1_port;
    d.choice1Angle=data.choice1_rotation;
    d.choice1AvailOn=data.choice1_availOn;
    d.choice1AvailOff=data.choice1_availOff;
    d.choice1Match=data.choice1_ismatch;
    d.choice1Coords=data.grasp_coords_left;
    d.choice1Rotation=data.choice1_rotation;
    
    %choice 2 (right touch) info
    d.choice2Mode=data.choice2_mode;
    d.choice2ID=data.choice2_id;
    d.choice2Port=data.choice2_port;
    d.choice2Angle=data.choice2_rotation;
    d.choice2AvailOn=data.choice2_availOn;
    d.choice2AvailOff=data.choice2_availOff;
    d.choice2Match=data.choice2_ismatch;
    d.choice2Coords=data.grasp_coords_right;
    d.choice2Rotation=data.choice2_rotation;
    
    %psychophys data
    d.ems=data.ems;
    d.ems2=data.ems2;
    d.sacStart=data.sactimes;
    d.sacStop=data.sacstops;
    d.graspTimes=data.grasp_pcts_times;
    d.graspLeftTimes=data.grasp_pcts_left_times;
    d.graspRightTimes=data.grasp_pcts_right_times;
    d.graspPctsLeft=data.grasp_pcts_left;
    d.graspPctsRight=data.grasp_pcts_right;
    d.graspValsLeft=data.grasp_vals_left;
    d.graspValsRight=data.grasp_vals_right;
    
    
    %Check grasp times
    
    for i=1:size(d.graspLeftTimes,1)
        these=d.graspLeftTimes{i,1};
        list=[list; these(1:5:50)'];
        if these(20) > 1000
            disp([filename ' Date: ' num2str(d.date(i)) ' Block: ' num2str(d.blocks(i))])
        end
    end
    
    
end











