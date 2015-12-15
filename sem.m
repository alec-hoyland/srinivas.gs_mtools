% sem.m
% computes standard error of mean of a matrix
%
% created by Srinivas Gorur-Shandilya at 11:55 , 14 July 2015. Contact me at http://srinivas.gs/contact/
% 
% This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
% To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.

function y = sem(x)

y = nanstd(x);
n = sum(~isnan(x));
y = y./sqrt(n);

