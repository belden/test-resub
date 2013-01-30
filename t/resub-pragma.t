#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use lib '../lib';

sub foo::bar { 'foo' }

is( foo->bar, 'foo' );

{
	package away;
	use resub foo => [bar => sub { 'bar' }];
	main::is( foo->bar, 'bar' );

	no resub 'foo::bar';
	main::is( foo->bar, 'foo' );
}

