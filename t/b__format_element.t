#!/usr/bin/env perl

use 5.008001;
use utf8;
use strict;
use warnings;

use version; our $VERSION = qv('v0.0.3');


use PPI::Token::Word;
use PPIx::Grep;
use Readonly;


use Test::More tests => 7;


Readonly my $CHOMPED_WORD_CONTENT   => 'test_word';
Readonly my $WORD_CONTENT           => "$CHOMPED_WORD_CONTENT\n";
Readonly my $WORD                   => PPI::Token::Word->new($WORD_CONTENT);
Readonly my $FILENAME               => 'an example file name';
Readonly my $TEST_LINE_NUMBER       => 53;
Readonly my $TEST_CHARACTER_NUMBER  => 194;
Readonly my $TEST_COLUMN_NUMBER     => 396;
Readonly my $LOCATION => [
    $TEST_LINE_NUMBER,
    $TEST_CHARACTER_NUMBER,
    $TEST_COLUMN_NUMBER,
];


## no critic (Subroutines::ProtectPrivateSubs)

PPIx::Grep::set_print_format('x');
is(
    PPIx::Grep::_format_element($WORD, $FILENAME, $LOCATION),
    'x',
    'format with no substitutable value returns the format.',
);

PPIx::Grep::set_print_format('%f');
is(
    PPIx::Grep::_format_element($WORD, $FILENAME, $LOCATION),
    $FILENAME,
    q<"%f" returns the filename.>,
);

PPIx::Grep::set_print_format('%l');
is(
    PPIx::Grep::_format_element($WORD, $FILENAME, $LOCATION),
    $TEST_LINE_NUMBER,
    q<"%l" returns the line number.>,
);

PPIx::Grep::set_print_format('%c');
is(
    PPIx::Grep::_format_element($WORD, $FILENAME, $LOCATION),
    $TEST_CHARACTER_NUMBER,
    q<"%c" returns the character number.>,
);

PPIx::Grep::set_print_format('%C');
is(
    PPIx::Grep::_format_element($WORD, $FILENAME, $LOCATION),
    $TEST_COLUMN_NUMBER,
    q<"%C" returns the column number.>,
);

PPIx::Grep::set_print_format('%s');
is(
    PPIx::Grep::_format_element($WORD, $FILENAME, $LOCATION),
    $WORD_CONTENT,
    q<"%s" returns the element content.>,
);

PPIx::Grep::set_print_format('%S');
is(
    PPIx::Grep::_format_element($WORD, $FILENAME, $LOCATION),
    $CHOMPED_WORD_CONTENT,
    q<"%S" returns the chomped element content.>,
);

# setup vim: set filetype=perl tabstop=4 softtabstop=4 expandtab :
# setup vim: set shiftwidth=4 shiftround textwidth=78 nowrap autoindent :
# setup vim: set foldmethod=indent foldlevel=0 :
