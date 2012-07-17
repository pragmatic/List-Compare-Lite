#!/usr/bin/env perl

#  COPYRIGHT: © 2012 Peter Hallam
#   ABSTRACT: Test the three main functions
#    PODNAME: 01-basic.t
#    CREATED: Sun, 15 Jul 2012 06:55:45 UTC
#     AUTHOR: Peter Hallam <pragmatic@cpan.org>

use strict;
use warnings;
use v5.10;

use Test::More 'no_plan';

use_ok( 'List::Compare::Lite', ':all' )
    or BAIL_OUT;

my @list_a = ( qw{ a b c 3 4 5 } );
my @list_b = ( qw{ c d e 1 2 3 } );

my $intersection    = intersection  ( \@list_a, \@list_b );
my $difference      = difference    ( \@list_a, \@list_b );
my $union           = union         ( \@list_a, \@list_b );

ok( $intersection ~~ [ qw{ 3 c }                    ], 'intersection'   );
ok( $difference   ~~ [ qw{ e a d 2 1 4 b 5 }        ], 'difference'     );
ok( $union        ~~ [ qw{ e a 3 d 2 1 4 c b 5 }    ], 'union'          );

# vim:set ts=4 sw=4 et ft=perl:
