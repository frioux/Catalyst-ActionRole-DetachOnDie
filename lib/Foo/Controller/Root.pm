package Foo::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

Foo::Controller::Root - Root Controller for Foo

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub base : Chained('/') PathPart('') CaptureArgs(0) ActionClass('Test') {
     my ( $self, $c ) = @_;

    $c->log->warn("In base");
    die("base");
}

sub foo : Chained('base') PathPart('') CaptureArgs(0) ActionClass9('Test'){
     my ( $self, $c ) = @_;

    $c->log->warn("In foo");
#    die("foo");
}

sub index : Chained('foo') PathPart('') Args(0) ActionClass('Test'){
    my ( $self, $c ) = @_;

    $c->log->warn("In index");
    die("Index");
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Tomas Doran

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
