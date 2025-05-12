clc; clear;

%% =========================================================================
%  Script Name: Climate Model Grid Output ANOVA
%  Description: Performs a 3-way ANOVA on climate model grid outputs.
%  Author     : Dr. Zafer Ali Serbes
%  Created on : 12 May 2025
%  =========================================================================
%

%% === ANOVA Analysis for Climate Model Grid Outputs ===
% This script performs a 3-way ANOVA on grid-based climate model outputs.
% It analyzes the contributions of Model, Scenario, and Coefficient factors,
% including their interactions, to the variance in each grid column.
%
% INPUT:
%   - A .mat file containing a cell array named 'climate_grid_data'.
%     The array must follow this structure:
%       Column 1        : Year
%       Columns 2 to N-3: Grid data (Grid_1, Grid_2, ..., Grid_n)
%       Column N-2      : Model name
%       Column N-1      : Scenario
%       Column N        : Coefficient
%
% NOTE:
%   ?: Update the 'base_path' and 'data_file' variables below to match your data location.
%   ?: The loaded variable in the .mat file must be named 'climate_grid_data'.
%   ?: All factors (Model, Scenario, Coefficient, and interactions) should be analyzed for each grid.
%   ?: The results will be displayed separately for each grid and should be interpreted as a stack of analyses.

%% === Define File Path ===
% Set your data directory and file name here
base_path = '';         % <-- [INSERT YOUR FOLDER PATH HERE]
data_file = '';         % <-- [INSERT YOUR FILE NAME HERE, e.g., 'climate_data.mat']
data_path = fullfile(base_path, data_file);

%% === Load Data ===
% The loaded variable must be named 'climate_grid_data'
load(data_path, 'climate_grid_data');

%% === Determine Grid Count and Create Table ===
total_columns = size(climate_grid_data, 2);
num_grids = total_columns - 4;  % 1 year column + 3 metadata columns

% Generate grid names
grid_names = cell(1, num_grids);
for i = 1:num_grids
    grid_names{i} = ['Grid_' num2str(i)];
end

% Set column headers for table
headers = [{'Year'}, grid_names, {'Model', 'Scenario', 'Coefficient'}];

% Convert cell array to table for easier handling
T = cell2table(climate_grid_data, 'VariableNames', headers);

%% === ANOVA Analysis for Selected Grid Column ===
% Choose the grid you want to analyze (e.g., 'Grid_1')
selected_grid = 'Grid_1';
Y = T.(selected_grid);  % Dependent variable

% Define categorical factors
model = categorical(T.Model);
scenario = categorical(T.Scenario);
coefficient = categorical(T.Coefficient);

% Perform ANOVA (including all interactions)
[p, tbl, stats, terms] = anovan(Y, {model, scenario, coefficient}, ...
    'model', 'interaction', ...
    'varnames', {'Model', 'Scenario', 'Coefficient'}, ...
    'display', 'off');

%% === Calculate and Display Variance Contributions ===
% Extract Sum of Squares and compute variance percentages
SS_col = cell2mat(tbl(2:end-1, 2));  % Skip total row
total_SS = sum(SS_col);
percent_var = (SS_col / total_SS) * 100;

% Create results table
factor_labels = tbl(2:end-1, 1);
result_table = table(factor_labels, percent_var, ...
    'VariableNames', {'Factor', 'VariancePercentage'});

% Display in Command Window
fprintf('\n=== ANOVA Variance Contributions for %s ===\n', selected_grid);
disp(result_table);

%% === Plot Bar Chart of Variance Contributions ===
figure('Name', 'ANOVA Variance Contributions', 'NumberTitle', 'off');
bar(percent_var, 'FaceColor', [0.2 0.5 0.8]);
xticks(1:length(percent_var));
xticklabels(factor_labels);
xtickangle(45);
ylabel('Explained Variance (%)');
title(sprintf('Variance Contributions for %s', selected_grid));
grid on;
