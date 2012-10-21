use strict;
use warnings FATAL => 'all';
use Module::Build;

Module::Build->new(
    name                 => 'autolocale',
    module_name          => 'autolocale',
    dist_author          => 'Hideaki Ohno<hide.o.j55@gmail.com>',
    license              => 'perl',
    recursive_test_files => 1,
    dynamic_config       => 0,
    build_requires       => {
        'Test::More'  => '0.98',
        'Test::Fatal' => 0,
    },
    configure_requires => { 'Module::Build' => '0.38' },
    requires           => {
        perl  => '5.010000',
        POSIX => 0,
    },
    recommends => { 'Variable::Magic' => 0, },
    no_index   => { 'directory'       => [ 't', 'xt', 'inc', 'eg' ] },
    test_files => ( -d '.git' || $ENV{RELEASE_TESTING} ) ? [qw(t/ xt/)] : ['t/'],
    create_readme  => 1,
    add_to_cleanup => ['autolocale-*'],
    meta_merge     => {
        keywords  => [qw/locale/],
        resources => {
            repository => 'git://github.com/hideo55/p5-autolocale.git',
            bugtracker => 'https://github.com/hideo55/p5-autolocale/issues',
        },
    },
)->create_build_script;
