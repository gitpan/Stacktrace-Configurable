package Stacktrace::Configurable::Frame;

use strict;
use 5.01;
our $VERSION = '0.01';

our @attr;

sub new {
    my $class=shift;
    $class=ref($class)||$class;

    my $I=bless {}=>$class;

    @{$I}{@attr} = @_;

    return $I;
}

BEGIN {
    @attr=(qw/package filename line subroutine hasargs
              wantarray evaltext is_require hints bitmask
              hinthash nr args/);
    for (@attr) {
        my $attr=$_;
        no strict 'refs';
        *{__PACKAGE__.'::'.$attr}=sub : lvalue {
            my $I=$_[0];
            $I->{$attr}=$_[1] if @_>1;
            $I->{$attr};
        };
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Stacktrace::Configurable::Frame - simple OO access to caller result

=head1 SYNOPSIS

 use Stacktrace::Configurable::Frame;

 # constructor
 $f=Stacktrace::Configurable::Frame->new($package,
                                         $filename,
                                         $line,
                                         $subroutine,
                                         $hasargs,
                                         $wantarray,
                                         $evaltext,
                                         $is_require,
                                         $hints,
                                         $bitmask,
                                         $hinthash,
                                         $nr,
                                         \@args);

 # accessor / mutator (lvalue functions)
 $f->package;
 $f->filename;
 $f->line;
 $f->subroutine;
 $f->hasargs;
 $f->wantarray;
 $f->evaltext;
 $f->is_require;
 $f->hints;
 $f->bitmask;
 $f->hinthash;
 $f->nr;
 $f->args;

=head1 DESCRIPTION

This module is used to represent stack frames generated by
L<Stacktrace::Configurable>.

=head1 AUTHOR

Torsten Förtsch E<lt>torsten.foertsch@gmx.netE<gt>

=head1 COPYRIGHT

Copyright 2014- Torsten Förtsch

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<StackTrace::Configurable>

=cut
