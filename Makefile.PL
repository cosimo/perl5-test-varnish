use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::Varnish',
    AUTHOR              => 'Cosimo Streppone <cosimo@cpan.org>',
    VERSION_FROM        => 'lib/Test/Varnish.pm',
    ABSTRACT_FROM       => 'lib/Test/Varnish.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
		'HTTP::Request' => 0,
		'HTTP::Response' => 0,
		'HTTP::Cookies' => 0,
		'LWP::UserAgent' => 0,
		'Getopt::Long' => 0,
		'URI' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-Varnish-*' },
);
