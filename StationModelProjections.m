function [baseline_model, P] = StationModelProjections(station_number, end_year)

% StationModelProjections Analyze modeled future temperature projections at individual stations
%===================================================================
%
% USAGE:  [OUTPUTS] = StationModelProjections(INPUTS) <--update here
%
% DESCRIPTION:
%   Use this function to calculate the annual climatology model projections
%   and trend over the projected period, for projection 
%   data from all stations in the Global Historical
%   Climatology Network (GHCN)
%
% INPUT:
%    staton_number: Number of the station from which to analyze historical temperature data
%    end_year: year through which to calculate the projected temperature
%    change
%
% OUTPUT:
%    baseline_model: [mean annual temperature over baseline period
%       (2006-2025); standard deviation of temperature over baseline period]
%    P: slope and intercept for a linear fit to annual mean temperature
%       values over the full 21st century modeled period
%    
%
% AUTHOR: Sara, Ilana, Madeline, February 9 2026
%
% REFERENCE:
%    Written for EESC 4464: Environmental Data Exploration and Analysis, Boston College
%    Data are from the a global climate model developed by the NOAA
%       Geophysical Fluid Dynamics Laboratory (GFDL) in Princeton, NJ - output
%       from the A2 scenario extracted by Sarah Purkey for the University of
%       Washington's Program on Climate Change
%==================================================================

%% Read and extract the data from your station from the csv file
filename = ['model' num2str(station_number) '.csv'];
%Extract the year and annual mean temperature data
%<--
stationdata = readtable(filename, 'VariableNamingRule','preserve');
years = stationdata{:,1};
tempAnnMean = stationdata{:,2};

%% Calculate the mean and standard deviation of the annual mean temperatures
%  over the baseline period over the first 20 years of the modeled 21st
%  century (2006-2025) - if you follow the template for output values I
%  provided above, you will want to combine these together into an array
%  with both values called baseline_model
 %<-- (this will take multiple lines of code - see the procedure you
 %followed in Part 1 for a reminder of how you can do this)
baseline = find(years >= 2006 & years <= 2025);
end_year_index = find(years == end_year);
baselineMean = mean(tempAnnMean(baseline));
baselineStd = std(tempAnnMean(baseline));
baseline_model = [baselineMean, baselineStd];


%% Calculate the 5-year moving mean smoothed annual mean temperature anomaly over the modeled period
% Note that you could choose to provide these as an output if you want to
% have these values available to plot.
anomaly = tempAnnMean - baselineMean; %<-- anomaly
m = movmean(anomaly,5); %<-- smoothed anomaly

%% Calculate the linear trend in temperature this station over the modeled 21st century period
P = polyfit(stationdata.Year(1:end_year_index), anomaly(1:end_year_index), 1);%<--

end