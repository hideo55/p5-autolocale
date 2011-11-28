use strict;
use Test::More;
use Test::Fatal;
use POSIX qw(setlocale LC_ALL LC_CTYPE LC_COLLATE LC_NUMERIC);

subtest "LANG" => sub {
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

subtest "LC_CTYPE" => sub{
    use autolocale;
    $ENV{LC_CTYPE} = 'C';
    my $loc = setlocale(LC_CTYPE);
    is $loc, "C";
    {
        local $ENV{LC_CTYPE} = "en_US";
        $loc = setlocale(LC_CTYPE);
        is $loc, "en_US", 'in local scope';
    }
    $loc = setlocale(LC_CTYPE);
    is $loc, "C", "out of 'local' scope";
};

subtest "LC_COLLAte" => sub{
    use autolocale;
    $ENV{LC_COLLATE} = 'C';
    my $loc = setlocale(LC_COLLATE);
    is $loc, "C";
    {
        local $ENV{LC_COLLATE} = "en_US";
        $loc = setlocale(LC_COLLATE);
        is $loc, "en_US", 'in local scope';
    }
    $loc = setlocale(LC_COLLATE);
    is $loc, "C", "out of 'local' scope";
};

subtest "LC_NUMERIC" => sub{
    use autolocale;
    $ENV{LC_NUMERIC} = 'C';
    my $loc = setlocale(LC_NUMERIC);
    is $loc, "C";
    {
        local $ENV{LC_NUMERIC} = "en_US";
        $loc = setlocale(LC_NUMERIC);
        is $loc, "en_US", 'in local scope';
    }
    $loc = setlocale(LC_NUMERIC);
    is $loc, "C", "out of 'local' scope";
};

subtest "Illegal usage" => sub {
    use autolocale;
    like exception {
        $ENV{"LANG"} = [];
    }, qr/^You must store scalar data to %ENV/;
};

done_testing();
