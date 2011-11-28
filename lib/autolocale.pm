package autolocale;
use strict;
use warnings;
use 5.010;
use POSIX qw(setlocale LC_ALL LC_CTYPE LC_COLLATE LC_NUMERIC);
use Variable::Magic qw(wizard cast dispell);

our $VERSION = '0.01';

my $get_value = sub {
    my $hinthash = ( caller(1) )[10];
    return unless $hinthash->{"autolocale"};
    my $arg = shift;
    if ( ref $arg ne 'SCALAR' ) {
        die q{You must store scalar data to %ENV};
    }
    my $locale = ${$arg};
    return $locale;
};

my $lang = wizard(
    set => sub {
        my $locale = $get_value->(@_);
        return unless $locale;
        setlocale( LC_ALL, $locale );
        return;
    }
);

my $ctype = wizard(
    set => sub {
        my $locale = $get_value->(@_);
        return unless $locale;
        setlocale( LC_CTYPE, $locale );
        return;
    }
);

my $collate = wizard(
    set => sub {
        my $locale = $get_value->(@_);
        return unless $locale;
        setlocale( LC_COLLATE, $locale );
        return;
    }
);

my $numeric = wizard(
    set => sub {
        my $locale = $get_value->(@_);
        return unless $locale;
        setlocale( LC_NUMERIC, $locale );
        return;
    }
);

sub import {
    $^H{"autolocale"} = 1;
    cast $ENV{"LANG"},       $lang;
    cast $ENV{"LC_CTYPE"},   $ctype;
    cast $ENV{"LC_COLLATE"}, $collate;
    cast $ENV{"LC_NUMERIC"}, $numeric;
}

sub unimport {
    $^H{"autolocale"} = 0;
}

1;
__END__

=head1 NAME

autolocale - auto call setlocale when set %ENV

=head1 SYNOPSIS

  use autolocale;
  
  $ENV{LANG} = "C";# auto call setlocale(LC_ALL, "C");

=head1 DESCRIPTION

autolocale is pragma moudle that auto call setlocale when set $ENV{"LANG"}, $ENV{"LC_CTYPE"}, $ENV{"LC_COLLATE"}, and $ENV{"LC_NUMERIC"}.

=head1 AUTHOR

Hideaki Ohno E<lt>hide.o.j55 {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
