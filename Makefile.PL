use inc::Module::Install;
name 'autolocale';
all_from 'lib/autolocale.pm';

recommends 'Variable::Magic';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More' => '0.94';
test_requires 'Test::Fatal';
auto_set_repository;
auto_include;
WriteAll;
