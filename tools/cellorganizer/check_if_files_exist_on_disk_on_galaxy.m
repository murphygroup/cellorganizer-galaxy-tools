function answer = check_if_files_exist_on_disk_on_galaxy( string )
% CHECK_IF_FILES_EXIST_ON_DISK Simple helper function that takes a string
% from Galaxy and checks if these strings match local filenames

% Ivan E. Cao-Berg (icaoberg@cmu.edu)
%
% Copyright (C) 2017 Murphy Lab
% Computational Biology Department
% Carnegie Mellon University
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published
% by the Free Software Foundation; either version 2 of the License,
% or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.
%
% For additional information visit http://murphylab.web.cmu.edu or
% send email to murphy@cmu.edu

galaxy_instance_setup();
answer = check_if_files_exist_on_disk( string );

end

function galaxy_instance_setup()
	current_directory = pwd;
	cellorganizer_directory = getenv('CELLORGANIZER');

	cd( cellorganizer_directory );
	setup();
	cd( current_directory );
end