package Foo::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

sub base : Chained('/') PathPart('') CaptureArgs(0) ActionClass('Test') {
     my ( $self, $c ) = @_;

    $c->stash->{body} = ['base'];
}

sub success : Chained('base') PathPart('success') Args(0) ActionClass('Test'){
     my ( $self, $c ) = @_;

    push @{$c->stash->{body}}, 'success';
}

sub fail : Chained('base') PathPart('fail') Args(0) ActionClass('Test'){
     my ( $self, $c ) = @_;

    die 'failed';
    push @{$c->stash->{body}}, 'fail';
}

sub middle_fail_1 : Chained('base') PathPart('middle_fail') CaptureArgs(0) ActionClass('Test'){
     my ( $self, $c ) = @_;

    die 'failed';
    push @{$c->stash->{body}}, 'middle_fail_1';
}

sub middle_fail_2 : Chained('middle_fail_1') PathPart('') Args(0) ActionClass('Test'){
     my ( $self, $c ) = @_;

    push @{$c->stash->{body}}, 'middle_fail_2';
}

sub end : ActionClass('RenderView') {
   my ($self, $c) = @_;

   $c->clear_errors;
   $c->response->body(join ', ', @{$c->stash->{body}});
}

__PACKAGE__->meta->make_immutable;

1;