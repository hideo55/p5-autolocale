use strict;
use Test::More;
use Test::Fatal;
use POSIX qw(setlocale LC_ALL);

SKIP: {
    my $loc_orig = setlocale( LC_ALL, '' );
    if(( $loc_orig || q{} ) eq 'C' ){
        # If $ENV{LANG} is 'C", try use 'en_US.UTF-8'.
        $loc_orig = setlocale( LC_ALL, 'en_US.UTF-8' );
        skip "Unspported locale(en_US.UTF-8)", 1 if ( $loc_orig || q{} ) ne 'en_US.UTF-8';
    }
    subtest "Basic usage" => sub {
        use autolocale;
        $ENV{LANG} = "C";
        my $loc = setlocale(LC_ALL);
        is $loc, "C", 'autolocale enable';
        {
            local $ENV{LANG} = $loc_orig;
            $loc = setlocale(LC_ALL);
            is $loc, $loc_orig, 'in local scope';
        }
        $loc = setlocale(LC_ALL);
        is $loc, "C", "out of 'local' scope";
        no autolocale;
        $ENV{LANG} = $loc_orig;
        $loc = setlocale(LC_ALL);
        is $loc, "C", 'no autolocale';
        {
            use autolocale;
            $ENV{LANG} = $loc_orig;
            $loc = setlocale(LC_ALL);
            is $loc, $loc_orig, 'lexical use';
        }
        $ENV{LANG} = "C";
        $loc = setlocale(LC_ALL);
        is $loc, $loc_orig, 'out of lexical pragma';
    };

    subtest "Illegal usage" => sub {
        use autolocale;
        like exception {
            $ENV{"LANG"} = [];
        }, qr/^You must store scalar data to %ENV/;
    };

}

done_testing();
