%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NIMISH DHAWAN
% pwrGenData
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% =======================================================================
% Unwrapping data
pwr_W1      = squeeze(simOut.Prw(1,1,:));
pwr_W2      = squeeze(simOut.Prw(2,1,:));
pwr_W3      = squeeze(simOut.Prw(3,1,:));
pwr_wh_W1   = sum(simOut.Prw(1,1,:))/3600;
pwr_wh_W2   = sum(simOut.Prw(2,1,:))/3600;
pwr_wh_W3   = sum(simOut.Prw(3,1,:))/3600;

% =======================================================================
% File Name and Location
% Change filename and location before running the script

pwr_report_LOC      = 'C:\Users\nimis\Documents\MATLAB\CUonOrbit\CUonOrbit_ADCSapp-NimishDhawan\DataFiles\'; 
pwr_report_filename = 'Power_Report';
pwr_report          = [pwr_report_LOC, pwr_report_filename, '.csv'];        % Add file location

fileID = fopen(pwr_report,'w');

% =======================================================================
% Wrapping and Writing Output

p_output = [tout, pwr_W1, pwr_W2, pwr_W3];

fprintf(fileID,'Time(s), Pwr_W1(W), Pwr_W2(W), Pwr_W3(W)\n');

for k = 1:size(p_output,1)
    fprintf(fileID,'%.1f, %.4f, %.4f, %.4f\n', p_output(k,1), ...
        p_output(k,2), p_output(k,3), p_output(k,4));
end

fprintf(fileID,'Power Consumed (Wh)\n');
fprintf(fileID, 'Wheel 1, %.4f\n', pwr_wh_W1);
fprintf(fileID, 'Wheel 2, %.4f\n', pwr_wh_W2);
fprintf(fileID, 'Wheel 3, %.4f\n', pwr_wh_W3);