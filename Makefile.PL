use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::Resub',
    AUTHOR              => 'AirWave Wireless <AIRWAVE@cpan.org>',
    VERSION_FROM        => 'lib/Test/Resub.pm',
    ABSTRACT_FROM       => 'lib/Test/Resub.pm',
    PL_FILES            => {},
    PREREQ_PM => {
      'Test::More' => 0,
      'Class::Std' => 0,
      'Scalar::Util' => 0,
      'Storable' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-Resub-*' },
);
