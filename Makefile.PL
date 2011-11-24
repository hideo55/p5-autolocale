use inc::Module::Install;
name 'autolocale';
all_from 'lib/autolocale.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
