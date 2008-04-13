use 5.008001;
use utf8;

use strict;
use warnings;

use English qw< −no_match_vars >;

use Module::Build;


my $class = Module::Build->subclass( code => <<'END_SUBCLASS' );

    sub ACTION_authortest {
        my $self = shift;

        $self->depends_on('build');
        $self->depends_on('manifest');
        $self->depends_on('distmeta');
        $self->recursive_test_files(1);
        $self->depends_on('test');

        return;
    } # end ACTION_authortest()

    sub ACTION_distdir {
        my $self = shift;

        $self->depends_on('authortest');

        return $self->SUPER::ACTION_distdir;
    } # end ACTION_distdir

END_SUBCLASS

my $builder = $class->new(
    module_name     => 'PPIx::Grep',
    license         => 'perl',
    dist_author     => 'Elliot Shank <perl@galumph.com>',
    dynamic_config  => 0,
    build_requires  => {
        'Test::Deep'    => 0.099,
        'Test::More'    => 0.72,
    },
    requires        => {
        'Carp'              => 0,
        'English'           => 0,
        'Exporter'          => 0,
        'Getopt::Long'      => 2.37,
        'List::MoreUtils'   => 0,
        'PPI'               => 1.201,
        'PPIx::Shorthand'   => 1,
        'Readonly'          => 1.03,
        'String::Format'    => 1.14,
        'strict'            => 0,
        'utf8'              => 0,
        'version'           => 0.74,
        'warnings'          => 0,
    },
    recommends      => {
    },
    meta_merge      => {
        configure_requires  => {
            'Module::Build' => 0.2808,
        },
    },
    script_files       => [ glob('examples/*') ],
    create_packlist    => 1,
    sign               => 0,
    add_to_cleanup     => [
        qw<
            MANIFEST
            MANIFEST.bak
            META.yml
            *.vim_backup
            *.tmp
            *.bak
            */*.vim_backup
            */*.tmp
            */*.bak
            */*/*.vim_backup
            */*/*.tmp
            */*/*.bak
            */*/*/*.vim_backup
            */*/*/*.tmp
            */*/*/*.bak
            */*/*/*/*.vim_backup
            */*/*/*/*.tmp
            */*/*/*/*.bak
            PPIx-Grep-*
        >
    ],
);


$builder->create_build_script();

# setup vim: set filetype=perl tabstop=4 softtabstop=4 expandtab :
# setup vim: set shiftwidth=4 shiftround textwidth=78 nowrap autoindent :
# setup vim: set foldmethod=indent foldlevel=0 :
