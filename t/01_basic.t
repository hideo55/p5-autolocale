use strict;
use Test::More;
use Test::Fatal;
use POSIX qw(setlocale LC_ALL);

SKIP: {
    my $loc = setlocale( LC_ALL, 'en_US.UTF-8' );
    skip "Unspported locale(en_US.UTF-8)", 1 if ( $loc || q{} ) ne 'en_US.UTF-8';
    subtest "Basic usage" => sub {
        use autolocale;
        $ENV{LANG} = "C";
        my $loc = setlocale(LC_ALL);
        is $loc, "C", 'autolocale enable';
        {
            local $ENV{LANG} = "en_US.UTF-8";
            $loc = setlocale(LC_ALL);
            is $loc, "en_US.UTF-8", 'in local scope';
        }
        $loc = setlocale(LC_ALL);
        is $loc, "C", "out of 'local' scope";
        no autolocale;
        $ENV{LANG} = "en_US.UTF-8";
        $loc = setlocale(LC_ALL);
        is $loc, "C", 'no autolocale';
        {
            use autolocale;
            $ENV{LANG} = "en_US.UTF-8";
            $loc = setlocale(LC_ALL);
            is $loc, "en_US.UTF-8", 'lexical use';
        }
        $ENV{LANG} = "C";
        $loc = setlocale(LC_ALL);
        is $loc, "en_US.UTF-8", 'out of lexical pragma';
    };

    subtest "Illegal usage" => sub {
        use autolocale;
        like exception {
            $ENV{"LANG"} = [];
        }, qr/^You must store scalar data to %ENV/;
    };

}

done_testing();
