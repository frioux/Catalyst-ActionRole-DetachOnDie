package Catalyst::Action::DetachOnDie;

use Moose;

# ABSTRACT: If something dies in a chain, stop the chain

extends 'Catalyst::Action';
with 'Catalyst::ActionRole::DetachOnDie';

no Moose;

1;

=pod

=head1 SYNOPSIS

 package MyApp::Controller::Foo;
 use Moose;

 BEGIN { extends 'Catalyst::Controller' }

 __PACKAGE__->config(
    action => {
       '*' => { ActionClass => 'DetachOnDie' },
    },
 );

 ...;

=head1 DESCRIPTION

See L<Catalyst::ActionRole::DetachOnDie> for what this thing really is.
