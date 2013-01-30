package resub;

use strict;
use warnings;

use Test::Resub qw(resub);

our %resub_objects;
our %listeners;

sub import {
	my ($class, @args) = @_;

	my $caller = caller;
	my %active = split /;/, ($^H{resub} || '');

	while (my ($target, $resubs) = splice @args, 0, 2) {
		while (my ($sub, $replacement) = splice @$resubs, 0, 2) {
			my $fqmn = "$target\::$sub";
			$active{$fqmn} = 1;
			if (! exists $resub_objects{$fqmn}) {
				$listeners{$fqmn}{-orig} = \&{$fqmn};

				$resub_objects{$fqmn} = resub $fqmn, sub {
					my $caller = caller(1);
					my $dispatch_to = exists $listeners{$fqmn}{$caller} && exists $active{$fqmn}
						? $listeners{$fqmn}{$caller}
						: $listeners{$fqmn}{-orig};
					goto $dispatch_to;
				};
			}

			$listeners{$fqmn}{$caller} = $replacement;
		}
	}

	$^H{resub} = join ';', %active;
}

sub unimport {
	my ($class, @doomed) = @_;
	my %active = split /;/, $^H{resub};
	my %doomed = map { $_ => 1 } @doomed;
	$^H{resub} = join ';', map { ($_, 1) } grep { ! $doomed{$_} } keys %active;
}

1;
