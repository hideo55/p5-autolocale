use strict;
use Test::More;
use Test::Fatal;
use POSIX qw(LC_ALL setlocale);

subtest "basic usage" => sub {
    use autolocale;
    $ENV{LANG} = "C";
    my $loc = setlocale(LC_ALL);
    is $loc, "C", 'autolocale enable';
    {
        local $ENV{LANG} = "en_US";
        $loc = setlocale(LC_ALL);
        is $loc, "en_US", 'in local scope';
    }
    $loc = setlocale(LC_ALL);
    is $loc, "C", "out of 'local' scope";
    no autolocale;
    $ENV{LANG} = "en_US";
    $loc = setlocale(LC_ALL);
    is $loc, "C", 'no autolocale';
    {
        use autolocale;
        $ENV{LANG} = "en_US";
        $loc = setlocale(LC_ALL);
        is $loc, "en_US", 'lexical use';
    }
    $ENV{LANG} = "C";
    $loc = setlocale(LC_ALL);
    is $loc, "en_US", 'out of lexical pragma';
};

subtest "Illegal usage" => sub {
    use autolocale;
    like exception {
        $ENV{"LANG"} = [];
    }, qr/^You must store scalar data in \$ENV{"LANG"}/;
};

done_testing();
