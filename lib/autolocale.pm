package autolocale;
use strict;
use warnings;
use POSIX qw(setlocale LC_ALL);
use Variable::Magic qw(wizard cast dispell);

our $VERSION = '0.01';

my $is_enable = sub {
    my $level = shift || 0;
    my $hinthash = ( caller($level) )[10];
    return $hinthash->{autolocale};
};

my $handler = sub {
    return unless $is_enable->(1);
    my $arg = shift;
    if ( ref $arg ne 'SCALAR' ) {
        die q{You must store scalar data in $ENV{"LANG"}};
    }
    my $locale = ${$arg};
    setlocale( LC_ALL, $locale );
    return;
};

my $wiz = wizard( set => $handler, );

sub import {
    shift;
    $^H{autolocale} = 1;
    cast $ENV{"LANG"}, $wiz;
}

sub unimport {
    shift;
    $^H{autolocale} = 0;
}

1;
__END__

=head1 NAME

autolocale - auto call setlocale when set $ENV{LANG}

=head1 SYNOPSIS

  use autolocale;
  
  $ENV{LANG} = "C";# auto call setlocale(LC_ALL, "C");

=head1 DESCRIPTION

autolocale is pragma moudle that auto call setlocale when set $ENV{LANG}.

=head1 AUTHOR

Hideaki Ohno E<lt>hide.o.j55 {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
