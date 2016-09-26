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
    matlabBaseDir = 'Z:\code\matlab';
    diaryDir = 'D:\matlab_diary\';
else
    matlabBaseDir = '~/code/matlab';
    [~,home] = system('echo $HOME');
    diaryDir = fullfile(home(1:end-1), '.matlab_diary/');
end
addpath('.')
addpath(matlabBaseDir);
addpath(fullfile(matlabBaseDir, 'mimLib'));
dirs = findMatlabDirs(matlabBaseDir);
addpath(dirs{:});
clear dirs

%% Turn off wavread warnings
%warning('off', 'MATLAB:audiovideo:wavread:functionToBeRemoved');
%warning('off', 'MATLAB:audiovideo:wavwrite:functionToBeRemoved');

% Infinite history
ensureDirExists(diaryDir);
diary(fullfile(diaryDir, [datestr(clock, 30) '.txt']));

fprintf('pwd = %s\n', pwd)
