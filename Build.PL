use strict;
use warnings;

use Module::Build;

# perldoc Module::Build::Cookbook and Module::Build::Authoring for
# details of how to influence the contents of the generated files.

my $build = Module::Build->new
    (
     module_name => 'Parse::Readelf',
     dist_version_from => 'lib/Parse/Readelf.pm', # finds $VERSION
     license => 'perl',
     create_readme => 0,
     create_makefile_pl => 'traditional',
     requires => { 'perl' => '5.6.1',
		   'Carp' => 0,
		   'File::Spec' => 0,
		   'Test::More' => 0
		 },
     # FIXME: add dependency to readelf!
     recommends => { 'Test::Pod' => 0, 'Test::Pod::Coverage' => 0 },
     # FIXME: add "example dependency" to gcc!
    );

$build->create_build_script;
