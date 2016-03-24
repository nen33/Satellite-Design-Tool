function results =  ProcessCSVRevisitTime(filename)
%% ProcessCSVRevisitTime.m
% results =  ProcessCSVRevisitTime('filename')
%
% This function reads a CSV file generated by STK and extracts the values
% of RevisitTime for each grid point to calculate max and mean values.
%
% Daniel Selva <dselva>
% 
%% Open CSV file
fid = fopen(filename,'r+');

% Check Open was successful
if fid == -1
    disp(['ProcessCSVRevisitTime: Error when opening file ' filename]);
    return
end

%% Read the file
C = textscan(fid,'%f%f%f','Headerlines',29,'Delimiter',',');
latitude        = C{1};
longitude       = C{2};
revisit_time    = C{3};

%% Calculations
max_revisit_time    = max(revisit_time);
mean_revisit_time   = mean(revisit_time);

%% Outputs
results(1) = max_revisit_time;
results(2) = mean_revisit_time;

% Close the file
fclose(fid);

return
%% end of ProcessCSVRevisitTime.m


