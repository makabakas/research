function eval_gnuplot_spectrum(conf)
% reads file generated by lwfs_ir.m and appends the spectrum to a gnuplot
% readible txt file

%*****************************************************************************
% Copyright (c) 2017      Fiete Winter                                       *
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

%% ===== Computation =====================================================
load([conf.directory, evalGenerateFilename(conf), '.mat'], 'res');
  
if exist(conf.datafile, 'file')
  [f, P] = gp_load(conf.datafile);
else
  f = res.f(2:end);
  P = [];
end
P = [P, db(res.P(2:end))];

gp_save( conf.datafile, [f, P] );

end