% === Set your output folder here ===
outputDir = 'C:\Users\nimis\Documents\MATLAB\CUonOrbit\CUonOrbit_ADCSapp-NimishDhawan\DataFiles\RW0001 Sim Data\';  % <- change me
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Get all open figures
figHandles = findall(0, 'Type', 'figure');

for i = 1:numel(figHandles)
    fig = figHandles(i);

    % Only save figures that have a Name
    figName = string(get(fig, 'Name'));
    if strlength(figName) == 0
        continue
    end

    % Read the Tag for extra filtering (Simulink scopes often set special tags)
    figTag = string(get(fig, 'Tag'));

    % ----- Exclusions -----
    % 1) Skip MATLAB App windows (common title is literally "MATLAB App" or contains it)
    if figName == "MATLAB App" || contains(figName, "MATLAB App", 'IgnoreCase', true)
        continue
    end

    % 2) Skip scopes (name contains "Scope", like "Scope", "Scope1", etc.)
    if startsWith(figName, "Scope", 'IgnoreCase', true) || contains(figName, "Scope", 'IgnoreCase', true)
        continue
    end

    % 3) Skip Simulink scope figures by Tag patterns (robust against variants)
    if contains(figTag, "SIMULINK", 'IgnoreCase', true) || contains(figTag, "SCOPE", 'IgnoreCase', true)
        continue
    end
    % ----------------------

    % Clean the figure name for a safe filename
    cleanName = regexprep(figName, '[^\w\s-]', '');
    cleanName = strtrim(regexprep(cleanName, '\s+', '_'));

    % Build a unique PDF path (avoid overwriting)
    pdfPath = fullfile(outputDir, cleanName + ".pdf");
    n = 2;
    while exist(pdfPath, 'file')
        pdfPath = fullfile(outputDir, sprintf('%s_%d.pdf', cleanName, n));
        n = n + 1;
    end

    % Export (vector PDF, uses on-screen figure size)
    exportgraphics(fig, pdfPath, 'ContentType', 'vector');

    fprintf('Saved: %s\n', pdfPath);
end

disp('✅ Done saving named, non-scope figures.');
