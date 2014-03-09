package Plack::Middleware::NonPHP;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.001";

use parent 'Plack::Middleware';

sub call {
    my ($self, $env) = @_;

    my $ua   = $env->{HTTP_USER_AGENT} || "";
    my $path = $env->{PATH_INFO} || "";

    if (!$ua || $ua =~ /ZmEu/ || $path =~ /\.php$/ || $path =~ m{^/php}) {
        my $message = 'Not Found';
        return [
            404,
            [
                'Content-Type' => 'text/plain',
                'Content-Length' => length($message),
            ],
            [$message],
        ];
    }
    $self->app->($env);
}



1;
__END__

=encoding utf-8

=head1 NAME

Plack::Middleware::NonPHP - non PHP

=head1 SYNOPSIS

    use Plack::Builder;

    builder {
        enalbe 'NonPHP';
        $app;
    };

=head1 DESCRIPTION

Plack::Middleware::NonPHP is ...

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@cpan.orgE<gt>

=cut

