use 5.006001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Parse::Readelf',
    VERSION_FROM      => 'lib/Parse/Readelf.pm', # finds $VERSION
    PREREQ_PM         => {},
# FIXME: add dependency to readelf!
# FIXME: add test dependency to gcc!
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Parse/Readelf.pm', # retrieve abstract from module
       AUTHOR         => 'Thomas Dorner <dorner (AT) pause.org>') : ()),
);
