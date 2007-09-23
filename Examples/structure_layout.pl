#!/usr/bin/perl
#
# This script extracts the layout of structures matching a given
# pattern from the debug information embedded in one or more object
# files.  (To ease debugging it also allows for pre-extracted object
# information in files ending with ".lst").
#
# Author: Thomas Dorner
# Copyright: (C) 2007 by Thomas Dorner (Artistic License)

use strict;
use warnings;

use File::Spec;

BEGIN {
    # allow for usage in directory where archive got unpacked:
    my @split_path = File::Spec->splitpath($0);
    my $libpath = File::Spec->catpath(@split_path[0..1]);
    $libpath = File::Spec->catdir($libpath, '..', 'lib');
    $libpath = File::Spec->rel2abs($libpath);
    push @INC, $libpath if -d $libpath;
    require Parse::Readelf;
};

die "usage: structure-layout.pl <regexp-for-identifier> <object-file>...\n"
    unless 2 <= @ARGV;

my $re_identifier = shift @ARGV;

# save commands to reset them if changed later:
my $prdl_cmd = $Parse::Readelf::Debug::Line::command;
my $prdi_cmd = $Parse::Readelf::Debug::Info::command;

{
    no warnings 'once';
    $Parse::Readelf::Debug::Info::re_substructure_filter =
	join('|',
	     # don't expand some of our special structures as substructures:
	     '^CVarArea$',
	     '^CVarString$',
	     '^TArea<',
	     '^TArray<',
	     '^TBit<',
	     '^TBitMatrix<',
	     '^TFixString<',
	     # ignore some standard structures when expanding substructures:
	     '^basic_string');
}

# loop over objects:
foreach my $object (@ARGV)
{
    # handle preextracted lists:
    if ($object =~ m/\.lst$/)
    {
	$Parse::Readelf::Debug::Line::command = 'cat';
	$Parse::Readelf::Debug::Info::command = 'cat';
    }
    else
    {
	$Parse::Readelf::Debug::Line::command = $prdl_cmd;
	$Parse::Readelf::Debug::Info::command = $prdi_cmd;
    }

    # parse object and print structure layout for matching identifiers:
    my $readelf_data = new Parse::Readelf($object);
    $readelf_data->print_structure_layout($re_identifier, 1);
}
