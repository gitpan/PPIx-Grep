use 5.008001;
use strict;
use warnings;

use English qw< −no_match_vars >;

use Module::Build;


my $class = Module::Build->subclass( code => <<'SUBCLASS' );

    sub ACTION_authortest {
        my $self = shift;

        $self->depends_on('build');
        $self->depends_on('manifest');
        $self->depends_on('distmeta');
        $self->recursive_test_files(1);
        $self->depends_on('test');
    } # end ACTION_authortest()

    sub ACTION_distdir {
        my $self = shift;

        $self->depends_on('authortest');

        $self->SUPER::ACTION_distdir;
    } # end ACTION_distdir

SUBCLASS

my $builder = $class->new(
    module_name     => 'PPIx::Grep',
    license         => 'perl',
    dist_author     => 'Elliot Shank <perl@galumph.com>',
    dynamic_config  => 0,
    build_requires  => {
    },
    requires        => {
        'version'   => 0,
        'Readonly'  => 0,
        'PPI'       => 1.201,
    },
    recommends      => {
    },
    script_files       => [ glob('bin/*') ],
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
