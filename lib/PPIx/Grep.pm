package PPIx::Grep;

use utf8;
use 5.008001;
use strict;
use warnings;

use version; our $VERSION = qv('v0.0.2');

use Exporter qw< import >;

our @EXPORT_OK =
    qw<
        search_and_emit
    >;
our %EXPORT_TAGS    = (
    all => [@EXPORT_OK],
);

use Carp qw< confess >;
use Readonly;

use PPI::Document;


Readonly my $NUMBER_OF_PPI_LOCATION_COMPONENTS => 3;


sub search_and_emit {
    my ($source, $query, $destination) = @_;

    my $document = PPI::Document->new($source)
        or confess 'Could not parse source.';
    $document->index_locations();

    my $elements = $document->find($query);
    if ($elements) {
        foreach my $element ( @{$elements} ) {
            my $location = $element->location();
            my @location_components;
            if ($location) {
                @location_components = @{$location};
            } else {
                @location_components = (q<>) x $NUMBER_OF_PPI_LOCATION_COMPONENTS;
            } # end if

            print
                {$destination}
                join q<:>, $source, @location_components, $element;
            print {$destination} "\n";
        } # end foreach
    } # end if

    return;
} # end search_and_emit

1; # Magic true value required at end of module

__END__

=encoding utf8

=for stopwords TODO

=head1 NAME

PPIx::Grep - Search L<PPI> documents (not Perl code).


=head1 VERSION

This document describes PPIx::Grep version 0.0.2.


=head1 SYNOPSIS

TODO


=head1 DESCRIPTION

TODO


=head1 INTERFACE

Nothing is exported by default, but you can import everything using the
C<:all> tag.

=over

=item C< search_and_emit($source, $query, $destination) >

Attempts to parse the document, find elements that match the criteria, and
emit them to the specified file-handle.


=back


=head1 DIAGNOSTICS

TODO


=head1 CONFIGURATION AND ENVIRONMENT

TODO


=head1 DEPENDENCIES

TODO


=head1 INCOMPATIBILITIES

TODO


=head1 BUGS AND LIMITATIONS

=over

=item · TODO

=back

Please report any bugs or feature requests to
C<bug-ppix-grep@rt.cpan.org>, or through the web
interface at L<http://rt.cpan.org>.


=head1 AUTHOR

Elliot Shank  C<< <perl@galumph.com> >>


=head1 LICENSE AND COPYRIGHT

Copyright ©2007, Elliot Shank C<< <perl@galumph.com> >>. All rights
reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY FOR THE
SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE
STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE
SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND
PERFORMANCE OF THE SOFTWARE IS WITH YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE,
YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY
COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR REDISTRIBUTE THE
SOFTWARE AS PERMITTED BY THE ABOVE LICENSE, BE LIABLE TO YOU FOR DAMAGES,
INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
OUT OF THE USE OR INABILITY TO USE THE SOFTWARE (INCLUDING BUT NOT LIMITED TO
LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR
THIRD PARTIES OR A FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER
SOFTWARE), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGES.

=cut

# setup vim: set filetype=perl tabstop=4 softtabstop=4 expandtab :
# setup vim: set shiftwidth=4 shiftround textwidth=78 nowrap autoindent :
# setup vim: set foldmethod=indent foldlevel=0 :
