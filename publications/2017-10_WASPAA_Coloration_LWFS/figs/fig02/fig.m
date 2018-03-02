% Spectrum of reproduced sound field

%*****************************************************************************
% Copyright (c) 2018      Fiete Winter                                       *
%                         Institut fuer Nachrichtentechnik                   *
%                         Universitaet Rostock                               *
%                         Richard-Wagner-Strasse 31, 18119 Rostock, Germany  *
%                                                                            *
% This file is part of the supplementary material for Fiete Winter's         *
% scientific work and publications                                           *
%                                                                            *
% You can redistribute the material and/or modify it  under the terms of the *
% GNU  General  Public  License as published by the Free Software Foundation *
% , either version 3 of the License,  or (at your option) any later version. *
%                                                                            *
% This Material is distributed in the hope that it will be useful, but       *
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY *
% or FITNESS FOR A PARTICULAR PURPOSE.                                       *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy of the GNU General Public License along   *
% with this program. If not, see <http://www.gnu.org/licenses/>.             *
%                                                                            *
% http://github.com/fietew/publications           fiete.winter@uni-rostock.de*
%*****************************************************************************

clear
addpath('../../matlab');
brs_parameters;

%% parameters which should be iterated

% parameters which should be varied for the evaluation
% #1: reproduction method
% #2: listener position
% #3: number of plane wave in pwd ('lwfs-sbl' only)
% #4: modal order in circular expansion ('lwfs-sbl' only)
% #5: fhigh of wfs-prefilter ('wfs' and 'lwfs-sbl')

param_names = { 'method', ...
  'pos', ...
  'localwfs_sbl.Npw', ...
  'localwfs_sbl.order', ...
  'wfs.hprefhigh'};

%% generate disired combinations of parameter values

param_values = {};

% first MUSHRA with listener at [0,0,0]
param_values = [param_values; allcombs( ...
  {'wfs', 'nfchoa', 'stereo'}, ...
  {[0,0,0]}, ...
  {NaN}, ...
  {NaN}, ...
  {1600, NaN, NaN}, ...
  [1,2,3,4,1])];
param_values = [param_values; allcombs( ...
  {'lwfs-sbl'}, ...
  {[0,0,0]}, ...
  {1024, 512, 256, 128, 64}, ...
  {27}, ...
  {20000, 17500, 8200, 3200, 1500}, ...
  [1:2,3,4,3])];

% second MUSHRA with listener at [-0.5,0.75,0]
param_values = [param_values; allcombs( ...
  {'wfs', 'nfchoa', 'stereo'}, ...
  {[-0.5,0.75,0]}, ...
  {NaN}, ...
  {NaN}, ...
  {1600, NaN, NaN}, ...
  [1,2,3,4,1])];
param_values = [param_values; allcombs( ...
  {'lwfs-sbl'}, ...
  {[-0.5,0.75,0]}, ...
  {1024, 512, 256, 128, 64}, ...
  {27}, ...
  {20000, 11500, 5200, 2700, 1100}, ...
  [1,2,3,4,3])];

% second MUSHRA with listener at [-0.5,0.75,0] and different modal orders
param_values = [param_values; allcombs( ...
  {'lwfs-sbl'}, ...
  {[-0.5,0.75,0]}, ...
  {1024}, ...
  num2cell(23:-4:3), ...
  {20000} ...
  )];

param_values

%% Evaluation
% compute brs files
exhaustive_evaluation(@brs_driving_signals, param_names, param_values, ...
  conf, true);

% compute and plot some frequency spectra
exhaustive_evaluation(@eval_spectrum, param_names, param_values, conf, false);

% store spectra in gnuplot-compatible file
delete(conf.datafile);
exhaustive_evaluation(@eval_gnuplot_spectrum, param_names, param_values, ...
  conf, false);