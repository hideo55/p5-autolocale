use strict;
use Test::More;
use Test::Fatal;
use POSIX qw(setlocale LC_ALL);

setlocale( LC_ALL, "C" );
setlocale( LC_ALL, "POSIX" );
my $loc = setlocale(LC_ALL);
SKIP: {
    skip "locale not supporting", 1 unless $loc eq 'POSIX';
    subtest "Basic usage" => sub {
        use autolocale;
        $ENV{LANG} = "C";
        my $loc = setlocale(LC_ALL);
        is $loc, "C", 'autolocale enable';
        {
            local $ENV{LANG} = "POSIX";
            $loc = setlocale(LC_ALL);
            is $loc, "POSIX", 'in local scope';
        }
        $loc = setlocale(LC_ALL);
        is $loc, "C", "out of 'local' scope";
        no autolocale;
        $ENV{LANG} = "POSIX";
        $loc = setlocale(LC_ALL);
        is $loc, "C", 'no autolocale';
        {
            use autolocale;
            $ENV{LANG} = "POSIX";
            $loc = setlocale(LC_ALL);
            is $loc, "POSIX", 'lexical use';
        }
        $ENV{LANG} = "C";
        $loc = setlocale(LC_ALL);
        is $loc, "POSIX", 'out of lexical pragma';
    };

}

subtest "Illegal usage" => sub {
    use autolocale;
    like exception {
        $ENV{"LANG"} = [];
    }, qr/^You must store scalar data to %ENV/;
};

done_testing();
