disp('Executing startup.m ...')

% Formats
format short g
format compact

% Weird incantations
%set(0,'DefaultFigureWindowStyle','docked')
try
    com.mathworks.mde.desk.MLDesktop.getInstance.getMainFrame ...
        .getStatusBar.getParent.setVisible(0);
catch
end
set(0,'DefaultFigureColormap',jet(256));

% Octave only
try
    save_default_options('-v7')
    more('off')
catch
end

% Paths
if ispc
    addpath('Z:\code\matlab', 'Z:\code\matlab\mimLib')
    diaryDir = 'D:\matlab_diary\';
else
    [~,home] = system('echo $HOME');
    addpath('~/code/matlab', '~/code/matlab/mimLib')
    diaryDir = fullfile(home(1:end-1), '.matlab_diary/');
    %warning('mim:startup:nodiary', 'No diary on linux')
end
dirs = findMatlabDirs(true);
addpath('.', dirs{:});
clear dirs

% Turn off warnings
warning('off', 'MATLAB:audiovideo:wavread:functionToBeRemoved');
warning('off', 'MATLAB:audiovideo:wavwrite:functionToBeRemoved');

% Infinite history
ensureDirExists(diaryDir);
diary(fullfile(diaryDir, [datestr(clock, 30) '.txt']));

fprintf('pwd = %s\n', pwd)
