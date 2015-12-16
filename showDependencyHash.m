% showDependencyHash
% shows the repository name and git commit hash of all dependencies in a given m file 
% 
% created by Srinivas Gorur-Shandilya at 2:39 , 15 December 2015. Contact me at http://srinivas.gs/contact/
% 
% This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
% To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.

function [] = showDependencyHash(this_file)

assert(ischar(this_file),'input argument should be a string')
assert(exist(this_file,'file')==2,'file not found.')

% intelligently search the path and make a list of m files that are likely to be user-generated
p = path;
p = [':' p];
c = strfind(p,pathsep);

allfiles = {};

for i = 2:length(c)
	this_folder = p(c(i-1)+1:c(i)-1);
	if ~any(strfind(this_folder,'MATLAB_R'))
		files_in_this_folder = dir([this_folder oss '*.m']);
		allfiles = [allfiles files_in_this_folder.name];
	end
end

% strip extention for each of these files
for i = 1:length(allfiles)
	allfiles{i} = allfiles{i}(1:end-2);
end

% search the file in question for these keywords
source_code = fileread(which(this_file));
is_dep = false(length(allfiles),1);
for i = 1:length(allfiles)
	if any(strfind(source_code,allfiles{i}))
		is_dep(i) = true;
	end
end

% find which folders they are in
allfolders = {};
dep_files = allfiles(is_dep);
for i = 1:length(dep_files)
	allfolders = [allfolders fileparts(which(dep_files{i}))];
end
allfolders = unique(allfolders);

original_folder = pwd;

% which of these are git repos?
for i = 1:length(allfolders)
	if exist([allfolders{i} oss '.git'],'file') == 7
		repo_name = allfolders{i}(max(strfind(allfolders{i},oss))+1:end);
		cd(allfolders{i})
		[status,m]=unix('git rev-parse HEAD');
		if ~status
			disp(['repo name:  ' repo_name '  commit:   ' m(1:7)])
		end
	end
end

cd(original_folder)





