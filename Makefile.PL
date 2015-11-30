###########################################################################
#
# Log::Agent::Rotate
#
# Copyright (c) 2000 Raphael Manfredi.
# Copyright (c) 2002, 2013 Mark Rogaski, mrogaski@cpan.org;
# all rights reserved.
#
# See the README file included with the
# distribution for license information.
#
###########################################################################

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'	=> 'Log::Agent::Rotate',
    'VERSION_FROM' => 'Rotate.pm', # finds $VERSION
	'BUILD_REQUIRES' => {
        'Test::More'        => '0',
        'File::Copy'        => '0',
		'Compress::Zlib'    => '0.4',
		'Getargs::Long'     => '0.103',
		'LockFile::Simple'  => '0.202',
		'Log::Agent'        => '0.201',
	},
	'PREREQ_PM' => {
		'Compress::Zlib'    => '0.4',
		'Getargs::Long'     => '0.103',
		'LockFile::Simple'  => '0.202',
		'Log::Agent'        => '0.201',
	},
    clean => {
        FILES => 't/*.out *~ File/*~ t/*~ t/logfile*',
    },
	'PM' => build_pm_hash(),
    'LIBS'	=> [''],		# e.g., '-lm'
    'DEFINE'	=> '',		# e.g., '-DHAVE_SOMETHING'
    'INC'	=> '',			# e.g., '-I/usr/include/other'
);

#
# build_pm_hash
#
# Find out all the *.pm files in the MANIFEST, and build a hash ref
# containing entries like:
#
#      'file.pm'    =>  '$(INST_LIBDIR)/file.pm'
#
# for each file.
#
sub build_pm_hash {
	local *MANI;
	open(MANI, "MANIFEST") || die "can't open MANIFEST: $!";
	local $_;
	my @pm;
	while (<MANI>) {
		my ($file, $comment) = split;
		next unless $file =~ /\.pm$/;
		push @pm, $file;
	}
	my %pm = map { $_ => '$(INST_LIBDIR)/' . $_ } @pm;
	return \%pm;
}
