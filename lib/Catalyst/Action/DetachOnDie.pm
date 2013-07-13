package Catalyst::Action::DetachOnDie;

use Moose;

# ABSTRACT: If something dies in a chain, stop the chain. DEPRECATED IN FAVOR OF CATALYST 5.90040

extends 'Catalyst::Action';
with 'Catalyst::ActionRole::DetachOnDie';

no Moose;

1;

=pod

=head1 DEPRECATED

Instead of using this module you should use Catalyst 5.90040 and set
the C<abort_chain_on_error_fix> flag.

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
