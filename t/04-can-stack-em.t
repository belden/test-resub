#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 1;

use lib '../lib';
use Test::Resub qw(resub);

{
	package Target::Class;

	sub green_monkey { 'ook' }
}

is( Target::Class->green_monkey, 'ook' );

sub get_stash {
	local $@;
	my %s = eval "%Target::Class::";
	return {%s};
}

{
local $MY::var = 1; # XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
$DB::single = 1 if $MY::var; # XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
1;1;	my $rs = resub 'Target::Class::green_monkey', sub { 'banana' };
	is( Target::Class->green_monkey, 'banana' );

	my $rs2 = resub 'Target::Class::green_monkey', sub { 'apple' };
	is( Target::Class->green_monkey, 'apple' );
	undef $rs2;

	# is( Target::Class->green_monkey, 'banana' );
}

is( Target::Class->green_monkey, 'ook' );
