#  COPYRIGHT: © 2012 Peter Hallam

package List::Compare::Lite;

#   ABSTRACT: Compare the elements of two lists
#    CREATED: Sun, 15 Jul 2012 05:31:00 UTC
#     AUTHOR: Peter Hallam <pragmatic@cpan.org>

use strict;
use warnings;
use 5.010001;

use Exporter ();

# VERSION

our ( @ISA, @EXPORT_OK, %EXPORT_TAGS );

BEGIN {
    @ISA       = qw{ Exporter };
    @EXPORT_OK = qw{
        compare compareref intersection difference union
    };
    %EXPORT_TAGS = ( all => \@EXPORT_OK, );
}

sub compare (\@\@) {
    my ( $array1, $array2 ) = @_;

    my ( @union, @intersection, @difference );
    my %count = ();

    for my $element ( @$array1, @$array2 ) { $count{ $element }++ }

    for my $element ( keys %count ) {
        push @union, $element;
        push @{ $count{ $element } > 1 ? \@intersection : \@difference }, $element;
    }

    return \@intersection, \@difference, \@union;
}

sub intersection {
    return ( compare( @{ $_[0] }, @{ $_[1] } ) )[0];
}

sub difference {
    return ( compare( @{ $_[0] }, @{ $_[1] } ) )[1];
}

sub union {
    return ( compare( @{ $_[0] }, @{ $_[1] } ) )[2];
}

1;

__END__

=encoding utf8

=for Pod::Coverage

=head1 SYNOPSIS

    use List::Compare::Lite ':all';

    my @list_a = ( qw{ a b c 3 4 5 } );
    my @list_b = ( qw{ c d e 1 2 3 } );

    my $intersection    = intersection  ( \@list_a, \@list_b );
    my $difference      = difference    ( \@list_a, \@list_b );
    my $union           = union         ( \@list_a, \@list_b );

    # or...

    my ( $intersection, $difference, $union )
       = compare( \@list_a, \@list_b );

    # $intersection ~~ [ qw{ 3 c }                    ]
    # $difference   ~~ [ qw{ e a d 2 1 4 b 5 }        ]
    # $union        ~~ [ qw{ e a 3 d 2 1 4 c b 5 }    ]

=head1 DESCRIPTION

For the given two lists, calculate:
=for :list
the intersection (which elements appear in both given arrays)
the (symmetric) difference (which elements appear in both given arrays, but not in both)
the union (which elements appear in both given arrays)

=func intersection

    my $intersection = intersection( \@array_1 \@array_2 );

Return an array reference to a list of items that appear one or more times in both lists (their intersection).

=func difference

    my $difference = difference( \@array_1 \@array_2 );

Returns an array reference to a list of items that appear one or more times in either the first or the second list, but not in both (their symmetric difference).

=func union

    my $union = union( \@array_1 \@array_2 );

Returns an array reference to a list of items that appear one or more times in either list (their union).

=head1 EXPORTS

Nothing by default. To import all of this module's symbols, do the conventional

    use List::Compare::Lite ':all';

It may make more sense though to only import the stuff your program actually
needs:

    use List::Compare::Lite qw{ difference };

=head1 SEE ALSO

This module is completely based of the code found in the L<perlfaq4|http://perldoc.perl.org/perlfaq4.html#How-do-I-compute-the-difference-of-two-arrays?-How-do-I-compute-the-intersection-of-two-arrays?>, so all credit must go to the author.

=for :list
C<List::Compare> is a more comprehensive and object-orientated module which provided the inspiration for the naming of this module.

=cut

# vim:set ts=4 sw=4 et ft=perl:
